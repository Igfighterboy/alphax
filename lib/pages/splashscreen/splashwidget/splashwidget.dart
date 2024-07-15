import 'package:flutter/material.dart';

class EllipsWidget extends StatelessWidget {
  final Color color;
  final double width;
  final double height;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  const EllipsWidget({
    super.key,
    required this.color,
    required this.width,
    required this.height,
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
        child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    ));
  }
}