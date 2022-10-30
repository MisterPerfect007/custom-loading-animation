import 'package:flutter/material.dart';

class WaveDots extends StatefulWidget {
  final double size;
  final Color color;

  const WaveDots({
    Key? key,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  State<WaveDots> createState() => _WaveDotsState();
}

class _WaveDotsState extends State<WaveDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  Widget _buildDot(
          {required Offset begin,
          required Offset end,
          required Interval interval}) =>
      Transform.translate(
        offset: Tween<Offset>(begin: begin, end: end)
            .animate(
              CurvedAnimation(
                parent: _controller,
                curve: interval,
              ),
            )
            .value,
        child: Container(
          width: widget.size / 11,
          height: widget.size / 11,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color,
          ),
        ),
      );

  Widget _buildBottomDot({required double begin, required double end}) {
    final double offset = -widget.size / 8;
    return _buildDot(
      begin: Offset.zero,
      end: Offset(0.0, offset),
      interval: Interval(begin, end),
    );
  }

  Widget _buildTopDot({required double begin, required double end}) {
    final double offset = -widget.size / 8;
    return _buildDot(
      begin: Offset(0.0, offset),
      end: Offset.zero,
      interval: Interval(begin, end),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.size;
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _controller.value <= 0.40
                      ? _buildBottomDot(begin: 0.0, end: 0.38)
                      : _buildTopDot(begin: 0.2, end: 0.5),
                  _controller.value <= 0.46
                      ? _buildBottomDot(begin: 0.06, end: 0.44)
                      : _buildTopDot(begin: 0.3, end: 0.6),
                  _controller.value <= 0.52
                      ? _buildBottomDot(begin: 0.12, end: 0.50)
                      : _buildTopDot(begin: 0.4, end: 0.7),
                  _controller.value <= 0.58
                      ? _buildBottomDot(begin: 0.18, end: 0.56)
                      : _buildTopDot(begin: 0.5, end: 0.8),
                  _controller.value <= 0.64
                      ? _buildBottomDot(begin: 0.24, end: 0.62)
                      : _buildTopDot(begin: 0.6, end: 0.9),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
