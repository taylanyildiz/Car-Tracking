import 'dart:math';

import 'package:ake_car_tracker/widgets/widget.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatefulWidget {
  CustomBottomSheet({
    Key? key,
    required this.header,
    required this.body,
    this.maxHeight,
    this.minHeight,
  }) : super(key: key);

  final Widget header;
  final Widget body;
  final double? minHeight;
  final double? maxHeight;

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

double maxHeight(BuildContext context) =>
    MediaQuery.of(context).size.height / 2;

class _CustomBottomSheetState extends State<CustomBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _gestureController;
  double _value = 0.0;
  @override
  void initState() {
    _gestureController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..addListener(() => setState(() => _value = _gestureController.value));
    super.initState();
  }

  @override
  void dispose() {
    _gestureController.dispose();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _gestureController.value -= details.primaryDelta! / maxHeight(context);
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_gestureController.isAnimating ||
        _gestureController.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / maxHeight(context);
    if (flingVelocity < 0.0)
      _gestureController.fling(velocity: max(2.0, -flingVelocity));
    else if (flingVelocity > 0.0)
      _gestureController.fling(velocity: min(-2.0, -flingVelocity));
    else
      _gestureController.fling(
          velocity: _gestureController.value < 0.5 ? -2.0 : 2.0);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Positioned(
      left: 0.0,
      right: 0.0,
      top: (height - (widget.minHeight ?? 100)) * (1 - _value) +
          (height - (widget.maxHeight ?? 200)) * _value,
      bottom: (height - (widget.minHeight ?? 100)) * (1 - _value) * -1,
      child: GestureDetector(
        onVerticalDragUpdate: _handleDragUpdate,
        onVerticalDragEnd: _handleDragEnd,
        child: Container(
          padding: EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 0.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade700,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade700,
                offset: Offset(4.0, 4.0),
                blurRadius: 25.0,
                spreadRadius: 2.0,
              ),
              BoxShadow(
                color: Colors.black,
                offset: -Offset(4.0, 4.0),
                blurRadius: 30.0,
                spreadRadius: 3.0,
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 20.0, 0.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff33383e),
                  Color(0xff2b2e33),
                  Color(0xff2b2e33),
                  Color(0xff1f2025),
                  Color(0xff1f2025),
                  Color(0xff17181c),
                ],
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 130.0,
                    vertical: 10.0,
                  ),
                  width: double.infinity,
                  height: 3.0,
                  color: Colors.black,
                ),
                Container(height: widget.minHeight, child: widget.header),
                SizedBox(height: 10.0),
                Expanded(child: widget.body),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
