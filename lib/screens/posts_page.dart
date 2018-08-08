import 'package:flutter/material.dart';
import 'package:polandball/api.dart';
import 'package:polandball/models/models.dart';
import 'package:polandball/screens/post_detail_page.dart';

class PostsPage extends StatefulWidget {
  static final PATH = "/posts";
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  RedditApi api = new RedditApi();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Polandball"),
        ),
        body: Container(
            child: FutureBuilder(
                future: api.getPosts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var posts = snapshot.data as List<Post>;
                    posts =
                        posts.where((p) => p.data.postHint == "image").toList();
                    return GridView.count(
                        crossAxisCount: 2,
                        children: List.generate(posts.length, (index) {
                          var post = posts[index];
                          return _generateImage(post.data.title,
                              post.data.thumbnail, post.data.url);
                        }));
                  }
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                })));
  }

  Widget _generateImage(String title, String thumbnailUrl, String imageUrl) {
    return InkWell(
      child: GridTile(
        child: Image.network(thumbnailUrl, fit: BoxFit.cover),
        footer: GridTileBar(
          backgroundColor: Colors.black45,
          title: Text(title),
        ),
      ),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => new PostDetailPage(imageUrl: imageUrl))),
    );
  }
}
