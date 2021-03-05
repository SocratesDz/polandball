import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:polandball/app/pages/post_detail_page.dart';

class GridPostImage extends StatefulWidget {
  final BuildContext context;
  final String id;
  final String title;
  final String thumbnailUrl;
  final String imageUrl;

  GridPostImage(
      {this.context, this.id, this.title, this.thumbnailUrl, this.imageUrl});

  @override
  GridPostImageState createState() => GridPostImageState();
}

class GridPostImageState extends State<GridPostImage>
    with TickerProviderStateMixin<GridPostImage> {
  AnimationController _controller;
  Animation _fadeAnimation;
  Animation _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _slideAnimation = Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
        .animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    var photoTag = PHOTO_DETAIL_HERO_TAG + widget.id;
    _controller.forward();
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black54, blurRadius: 0.0, spreadRadius: 0.0)
                ],
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.all(Radius.circular(2.0))),
            child: InkWell(
                child: GridTile(
                  child: Hero(
                      tag: photoTag,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: widget.thumbnailUrl,
                        placeholder: (_, __) {
                          return Container(
                            color: Colors.white,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                        errorWidget: (_, __, ___) {
                          return Container(
                            color: Colors.white,
                            child: Center(
                              child: IconButton(
                                  icon: Icon(Icons.error_outline),
                                  onPressed: () {}),
                            ),
                          );
                        },
                      )),
                  footer: ClipRect(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  color: Colors.black54, width: 2.0))),
                      child: GridTileBar(
                        backgroundColor: Colors.grey[200],
                        title: Text(
                          widget.title,
                          style: TextStyle(
                              color: Colors.black87, fontFamily: "Mali"),
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PostDetailPage(
                        imageUrl: widget.imageUrl,
                        thumbnailImage: widget.thumbnailUrl,
                        photoDetailTag: photoTag)))),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
