import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WigglyShapeBorder extends ShapeBorder {
  final double width;

  const WigglyShapeBorder({this.width: 1.0}) : assert(width != null);

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(width);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    final paint = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    canvas.drawPath(getOuterPath(rect), paint);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return new Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return new Path()
      ..lineTo(rect.right, rect.top)
      ..lineTo(rect.width, rect.bottom)
      ..lineTo(rect.left, rect.bottom)
      ..lineTo(rect.left, rect.top);
  }

  @override
  ShapeBorder scale(double t) {
    return WigglyShapeBorder(width: width * t);
  }
}
