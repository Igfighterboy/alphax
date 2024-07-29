import 'package:flutter/material.dart';

class WaveformPainter extends CustomPainter {
  final List<int> samples;
  final double progress;
  final Color activeColor;
  final Color inactiveColor;

  WaveformPainter({
    required this.samples,
    required this.progress,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    final activeWidth = size.width * progress;

    for (int i = 0; i < samples.length; i++) {
      final sample = samples[i];
      final x = i * (size.width / samples.length);
      final y = size.height - (sample / 255.0 * size.height);

      paint.color = x <= activeWidth ? activeColor : inactiveColor;
      canvas.drawLine(
        Offset(x, size.height),
        Offset(x, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
