import 'package:flutter/widgets.dart';

class WigglyShapeBorder extends ShapeBorder {
  final double width;

  const WigglyShapeBorder({
    this.width: 1.0
  }): assert(width != null);

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(width);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {

  }

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {

  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {

  }

  @override
  ShapeBorder scale(double t) {
    return WigglyShapeBorder(width: width * t);
  }
}