import 'package:polandball/api.dart';
import 'package:polandball/models/models.dart';
import 'package:polandball/screens/post_detail_page.dart';
import 'package:flutter/material.dart';

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
                          return _generateImage(
                              post.data.id,
                              post.data.title,
                              post.data.preview.images.first.source.url,
                              post.data.url);
                        }));
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Container(
                        child: Center(
                            child: IconButton(
                                icon: Icon(Icons.refresh), onPressed: () {})));
                  }
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                })));
  }

  Widget _generateImage(
      String id, String title, String thumbnailUrl, String imageUrl) {
    var photoTag = PHOTO_DETAIL_HERO_TAG + id;
    return FutureBuilder(
      future: api.getImageBytes(thumbnailUrl),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return InkWell(
            child: GridTile(
              child: Hero(
                  tag: PHOTO_DETAIL_HERO_TAG + id,
                  child: Image.memory(
                    snapshot.data,
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                  )),
              footer: GridTileBar(
                backgroundColor: Colors.black45,
                title: Text(title),
              ),
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => new PostDetailPage(
                    imageUrl: imageUrl,
                    thumbnailImage: thumbnailUrl,
                    photoDetailTag: photoTag))),
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Container(
            child: Center(
              child: IconButton(icon: Icon(Icons.refresh), onPressed: () {}),
            ),
          );
        }
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
