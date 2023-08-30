import 'package:flutter/material.dart';

class SizedTransitionWidget extends StatefulWidget {
  final Widget child;
  final Animation<double> animation;

  const SizedTransitionWidget(
      {super.key, required this.child, required this.animation});
  @override
  State<SizedTransitionWidget> createState() => _SizedTransitionWidgetState();
}

class _SizedTransitionWidgetState extends State<SizedTransitionWidget> {
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        sizeFactor: widget.animation,
        axis: Axis.vertical,
        axisAlignment: 1,
        child: widget.child);
  }
}
