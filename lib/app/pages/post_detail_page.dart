import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:polandball/data/repositories/api.dart';
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
  RedditApi api;

  @override
  void initState() {
    super.initState();
    api = RedditApi();
  }

  @override
  Widget build(BuildContext context) {
    //return _buildAlternateLayout();
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: _hideAppBarAndStatusBar,
                  child: Container(
                      child: FutureBuilder(
                    future: _loadImage(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return PhotoView.customChild(
                            child: Image(
                              image: MemoryImage(_imageBytes),
                              gaplessPlayback: true,
                              alignment: Alignment.topCenter,
                              fit: BoxFit.contain,
                            ),
                            childSize: const Size(220.0, 250.0),
                            basePosition: Alignment.center,
                            initialScale: PhotoViewComputedScale.contained,
                            minScale: PhotoViewComputedScale.contained,
                            maxScale: PhotoViewComputedScale.covered * 5.0);
                      }
                      return Container(
                        color: Colors.black,
                        child: Center(
                          child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: <Widget>[
                                Column(
                                  children: [
                                    Expanded(
                                      child: Hero(
                                          tag: widget.photoDetailTag,
                                          child: CachedNetworkImage(
                                            imageUrl: widget.thumbnailImage,
                                            fit: BoxFit.contain,
                                          )),
                                    )
                                  ],
                                ),
                                BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 5.0, sigmaY: 5.0),
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                              color:
                                                  Colors.black.withOpacity(0),
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator())),
                                        ),
                                      ],
                                    ))
                              ]),
                        ),
                      );
                    },
                  )),
                ),
              ),
            ],
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: 0.0,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 100),
              opacity: _visibleAppBar ? 1.0 : 0.0,
              child: AppBar(
                backgroundColor: APPBAR_COLOR,
                elevation: 0.0,
                primary: true,
                actions: <Widget>[
                  IconButton(icon: Icon(Icons.share), onPressed: _shareImage)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAlternateLayout() {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: _shareImage)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: _loadImage(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Image(
                    image: MemoryImage(_imageBytes),
                    gaplessPlayback: true,
                    alignment: Alignment.topCenter,
                    fit: BoxFit.contain,
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
            )
          ],
        ),
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
  }

  _hideAppBarAndStatusBar() {
    setState(() {
      _visibleAppBar = !_visibleAppBar;
      SystemChrome.setEnabledSystemUIOverlays(
          _visibleAppBar ? SystemUiOverlay.values : [SystemUiOverlay.bottom]);
    });
  }

  _shareImage() async {
    Directory tempDir = await getTemporaryDirectory();
    final filename = '${tempDir.path}/temp_image_share.png';
    File(filename).writeAsBytes(_imageBytes).then((file) {
      ShareExtend.share(file.path, "image");
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }
}
