import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
//import 'package:polandball/components/photo_view.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'package:advanced_share/advanced_share.dart';

const APPBAR_COLOR = Color.fromARGB(120, 0, 0, 0);

class PostDetailPage extends StatefulWidget {
  final int page;
  final String imageUrl;

  PostDetailPage({this.page, this.imageUrl});

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  var _visibleAppBar = true;
  Uint8List _imageBytes;
  var _base64Image = "";

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
                    imageProvider: NetworkImage(widget.imageUrl),
                    loadingChild: CircularProgressIndicator(),
                  );
                }
                return CircularProgressIndicator();
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

  Future<http.Response> _loadImage() =>
      http.get(widget.imageUrl).then((response) {
        setState(() => _setRawImage(response));
        return response;
      });

  _setRawImage(http.Response rawImage) {
    this._imageBytes = rawImage.bodyBytes;
    this._base64Image = base64Encode(rawImage.bodyBytes);
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
    AdvancedShare.generic(url: imageToShare);
  }
}
