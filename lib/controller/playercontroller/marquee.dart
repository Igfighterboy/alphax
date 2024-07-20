import 'package:flutter/material.dart';

class Marquee extends StatefulWidget {
  final String text;
  final double stepOffset;
  final Duration velocity;
  final double blankSpace;
  final TextStyle? style;

  Marquee({
    required this.text,
    this.stepOffset = 150.0,
    this.velocity = const Duration(milliseconds: 30),
    this.blankSpace = 20.0,
    this.style,
  });

  @override
  _MarqueeState createState() => _MarqueeState();
}

class _MarqueeState extends State<Marquee> {
  ScrollController? _scrollController;
  double _position = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollText());
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  void _scrollText() async {
    while (mounted) {
      await Future.delayed(widget.velocity);
      if (!mounted) return;
      setState(() {
        _position += 1;
        if (_position >= _scrollController!.position.maxScrollExtent + widget.blankSpace) {
          _position = 0.0;
          _scrollController!.jumpTo(_position);
        } else {
          _scrollController!.jumpTo(_position);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Text(widget.text, style: widget.style),
          SizedBox(width: widget.blankSpace),
          Text(widget.text, style: widget.style),
        ],
      ),
    );
  }
}
