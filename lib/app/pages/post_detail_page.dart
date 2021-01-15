import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
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
  bool _visibleAppBar;
  BaseCacheManager _cacheManager;

  @override
  void initState() {
    super.initState();
    _visibleAppBar = true;
    _cacheManager = DefaultCacheManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.black,
            child: PhotoView(
              basePosition: Alignment.topCenter,
              gaplessPlayback: true,
              initialScale: PhotoViewComputedScale.covered,
              minScale: PhotoViewComputedScale.covered,
              heroAttributes:
                  PhotoViewHeroAttributes(tag: widget.photoDetailTag),
              imageProvider: CachedNetworkImageProvider(widget.imageUrl,
                  cacheManager: _cacheManager),
              onTapUp: (_, __, ___) => _handleAppBar(),
              loadingBuilder: (_, __) => _buildLoadingWidget(),
            ),
          ),
          AnimatedPositioned(
            left: 0.0,
            right: 0.0,
            top: _visibleAppBar ? 0.0 : -80.0,
            duration: Duration(milliseconds: 300),
            curve: Curves.bounceOut,
            child: AppBar(
              backgroundColor: APPBAR_COLOR,
              elevation: 0.0,
              primary: true,
              actions: <Widget>[
                IconButton(icon: Icon(Icons.share), onPressed: _sharePost)
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleAppBar() {
    setState(() {
      _visibleAppBar = !_visibleAppBar;
      SystemChrome.setEnabledSystemUIOverlays(
          _visibleAppBar ? SystemUiOverlay.values : [SystemUiOverlay.bottom]);
    });
  }

  Widget _buildLoadingWidget() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Stack(alignment: AlignmentDirectional.center, children: <Widget>[
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
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        color: Colors.black.withOpacity(0),
                        child: Center(child: CircularProgressIndicator())),
                  ),
                ],
              ))
        ]),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  void _sharePost() async {
    final cachedPictureFileInfo =
        await _cacheManager.getFileFromCache(widget.imageUrl);
    if (cachedPictureFileInfo != null) {
      final pictureFile = cachedPictureFileInfo.file;
      ShareExtend.share(pictureFile.path, "image");
    }
  }
}
