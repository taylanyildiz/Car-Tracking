import 'dart:math';

import 'package:flutter/material.dart';

class CircleConcavButton extends StatefulWidget {
  CircleConcavButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.color,
    this.animController,
    this.animChild,
    this.autoReverse = false,
  }) : super(key: key);

  final Widget child;
  final Function() onPressed;
  final Color? color;
  final ConcavAnimController? animController;
  final Widget? animChild;
  final bool? autoReverse;

  @override
  _CircleConcavButtonState createState() => _CircleConcavButtonState();
}

class _CircleConcavButtonState extends State<CircleConcavButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _currentAnim;
  late Animation<double> _otherAnim;
  bool _onClick = false;
  bool _onClick1 = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _currentAnim = CurvedAnimation(
      parent: _controller,
      curve: Interval(.0, .5, curve: Curves.linear),
    )..addListener(() {
        setState(() {});
      });
    _otherAnim = CurvedAnimation(
      parent: _controller,
      curve: Interval(.45, 1.0, curve: Curves.linear),
    )..addListener(() {
        setState(() {});
      });
    if (widget.animController != null) {
      widget.animController!._addListener(() async {
        _onClick1 = !_onClick1;
        if (!widget.autoReverse!) {
          if (_onClick1) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
        } else {
          await _controller.forward();
          await _controller.reverse();
        }
      }, () => _controller.reverse());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animController == null) {
      return _null();
    } else {
      return _unNull();
    }
  }

  Widget _unNull() {
    return GestureDetector(
      onTapDown: (detail) {
        _onClick = true;
        setState(() {});
      },
      onTapUp: (detail) {
        _onClick = false;
        setState(() {});
        widget.onPressed.call();
      },
      onTapCancel: () => setState(() => _onClick = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        padding: EdgeInsets.all(_onClick ? 0.0 : 1.2),
        decoration: BoxDecoration(
          color: widget.color ?? Color(0xff30353b),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.white30,
              offset: _onClick ? Offset.zero : -Offset(8.0, 0.0),
              blurRadius: 30.0,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: Colors.black45,
              offset: _onClick ? Offset.zero : -Offset(8.0, 0.0),
              blurRadius: 35.0,
              spreadRadius: 3.0,
            ),
            BoxShadow(
              color: Colors.black54,
              offset: _onClick ? Offset.zero : Offset(8.0, 8.0),
              blurRadius: 25.0,
              spreadRadius: 3.0,
            ),
          ],
        ),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          padding: EdgeInsets.all(_onClick ? 14.0 : 15.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.color?.withOpacity(.6) ?? Color(0xff282d31),
                widget.color ?? Color(0xff212429),
              ],
              stops: [0.3, .7],
            ),
          ),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: 2 * pi * (1 - _currentAnim.value),
                    child: Opacity(
                      opacity: 1 - _currentAnim.value,
                      child: Center(child: widget.child),
                    ),
                  ),
                  Transform.rotate(
                    angle: 2 * pi * _otherAnim.value,
                    child: Opacity(
                      opacity: _otherAnim.value,
                      child: Center(child: widget.animChild),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _null() => GestureDetector(
        onTapDown: (detail) {
          _onClick = true;
          setState(() {});
        },
        onTapUp: (detail) {
          _onClick = false;
          setState(() {});
          widget.onPressed.call();
        },
        onTapCancel: () => setState(() => _onClick = false),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          padding: EdgeInsets.all(_onClick ? 0.0 : 1.2),
          decoration: BoxDecoration(
            color: widget.color ?? Color(0xff30353b),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.white30,
                offset: _onClick ? Offset.zero : -Offset(8.0, 0.0),
                blurRadius: 30.0,
                spreadRadius: 1.0,
              ),
              BoxShadow(
                color: Colors.black45,
                offset: _onClick ? Offset.zero : -Offset(8.0, 0.0),
                blurRadius: 35.0,
                spreadRadius: 3.0,
              ),
              BoxShadow(
                color: Colors.black54,
                offset: _onClick ? Offset.zero : Offset(8.0, 8.0),
                blurRadius: 25.0,
                spreadRadius: 3.0,
              ),
            ],
          ),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 100),
            padding: EdgeInsets.all(_onClick ? 14.0 : 15.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  widget.color?.withOpacity(.6) ?? Color(0xff282d31),
                  Color(0xff212429),
                ],
                stops: [0.3, .7],
              ),
            ),
            child: Center(child: widget.child),
          ),
        ),
      );
}

class ConcavAnimController {
  ConcavAnimController();

  late Function() _onAnim;
  late Function() _onReverse;

  _addListener(Function() onAnim, Function() onReverse) {
    this._onAnim = onAnim;
    this._onReverse = onReverse;
  }

  void onAnim() => _onAnim();

  void onReverse() => _onReverse();
}
