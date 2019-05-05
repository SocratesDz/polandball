import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:polandball/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_extend/share_extend.dart';

const APPBAR_COLOR = Color.fromARGB(120, 0, 0, 0);
const PHOTO_DETAIL_HERO_TAG = "PHOTO_DETAIL_HERO_TAG";

class PostDetailPage extends StatefulWidget {
  final int page;
  final String imageUrl;
  final String thumbnailImage;
  final String photoDetailTag;

  PostDetailPage(
      {this.page, this.imageUrl, this.thumbnailImage, this.photoDetailTag});

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  var _visibleAppBar = true;
  Uint8List _imageBytes;
  var _base64Image = "";
  RedditApi api;

  @override
  void initState() {
    super.initState();
    api = RedditApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: _hideAppBarAndStatusBar,
            child: Container(
                child: Center(
                    child: FutureBuilder(
              future: _loadImage(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return PhotoView(
                    imageProvider: MemoryImage(_imageBytes),
                    loadingChild: CircularProgressIndicator(),
                    basePosition: Alignment.topCenter,
                    initialScale: 0.7,
                    gaplessPlayback: true,
                  );
                }
                return Container(
                  color: Colors.black,
                  child: Center(
                    child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: <Widget>[
                          Hero(
                              tag: widget.photoDetailTag,
                              child: Image.network(
                                widget.thumbnailImage,
                                fit: BoxFit.cover,
                              )),
                          CircularProgressIndicator()
                        ]),
                  ),
                );
              },
            ))),
          ),
          AnimatedOpacity(
            opacity: _visibleAppBar ? 1.0 : 0.0,
            duration: Duration(milliseconds: 100),
            child: SizedBox(
                height: 80.0,
                child: AppBar(
                  backgroundColor: APPBAR_COLOR,
                  elevation: 0.0,
                  primary: true,
                  actions: <Widget>[
                    IconButton(icon: Icon(Icons.share), onPressed: _shareImage)
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Future<Uint8List> _loadImage() =>
      api.getImageBytes(widget.imageUrl).then((bytes) {
        setState(() => _setRawImage(bytes));
        return bytes;
      });

  _setRawImage(Uint8List bytes) {
    this._imageBytes = bytes;
    this._base64Image = base64Encode(bytes);
  }

  _hideAppBarAndStatusBar() {
    setState(() {
      _visibleAppBar = !_visibleAppBar;
      SystemChrome.setEnabledSystemUIOverlays(
          _visibleAppBar ? SystemUiOverlay.values : [SystemUiOverlay.bottom]);
    });
  }

  _shareImage() {
    var imageToShare = "data:image/png;base64,$_base64Image";
    ShareExtend.share(imageToShare, "text");
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }
}
