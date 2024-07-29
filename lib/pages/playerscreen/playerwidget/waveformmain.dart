import 'package:flutter/material.dart';
import 'package:myapp/pages/playerscreen/playerwidget/waveformpainter.dart';

class WaveformSlider extends StatefulWidget {
  final List<int> samples;
  final double progress;
  final Color activeColor;
  final Color inactiveColor;
  final ValueChanged<double> onChanged;

  WaveformSlider({
    required this.samples,
    required this.progress,
    required this.activeColor,
    required this.inactiveColor,
    required this.onChanged,
  });

  @override
  _WaveformSliderState createState() => _WaveformSliderState();
}

class _WaveformSliderState extends State<WaveformSlider> {
  double _localProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _localProgress = widget.progress;
  }

  void _handleTap(TapDownDetails details, BoxConstraints constraints) {
    final newProgress = details.localPosition.dx / constraints.maxWidth;
    setState(() {
      _localProgress = newProgress;
    });
    widget.onChanged(newProgress);
  }

  void _handleDrag(DragUpdateDetails details, BoxConstraints constraints) {
    final newProgress = (details.localPosition.dx / constraints.maxWidth).clamp(0.0, 1.0);
    setState(() {
      _localProgress = newProgress;
    });
    widget.onChanged(newProgress);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTapDown: (details) => _handleTap(details, constraints),
          onHorizontalDragUpdate: (details) => _handleDrag(details, constraints),
          child: CustomPaint(
            size: Size(double.infinity, 50),
            painter: WaveformPainter(
              samples: widget.samples,
              progress: _localProgress,
              activeColor: widget.activeColor,
              inactiveColor: widget.inactiveColor,
            ),
          ),
        );
      },
    );
  }
}
