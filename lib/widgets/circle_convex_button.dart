import 'package:flutter/material.dart';

class CircleConvexButton extends StatefulWidget {
  CircleConvexButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.padding,
    this.color,
  }) : super(key: key);

  final Function() onPressed;
  final Widget child;
  final Color? color;
  final double? padding;

  @override
  _CircleConvexButtonState createState() => _CircleConvexButtonState();
}

class _CircleConvexButtonState extends State<CircleConvexButton> {
  bool _onClick = false;

  _onTapUp(detail) {
    setState(() => _onClick = false);
    widget.onPressed.call();
  }

  _onTapDown(detail) {
    setState(() => _onClick = true);
  }

  _onTap() async {
    setState(() => _onClick = true);
    await Future.delayed(Duration(milliseconds: 100));
    setState(() => _onClick = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: _onTapUp,
      onTapDown: _onTapDown,
      onTap: _onTap,
      onTapCancel: () => setState(() => _onClick = false),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 100),
            padding: EdgeInsets.all(_onClick ? 0.0 : 3.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _onClick
                      ? widget.color?.withOpacity(.8) ?? Colors.white54
                      : widget.color?.withOpacity(.4) ?? Colors.white30,
                  widget.color ?? Colors.white,
                ],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade800,
                  offset: _onClick ? Offset.zero : -Offset(8.0, 8.0),
                  blurRadius: 25.0,
                  spreadRadius: 3.0,
                ),
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(8.0, 8.0),
                  blurRadius: 25.0,
                  spreadRadius: 3.0,
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(widget.padding ?? 35.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: FractionalOffset(0.35, 0.0),
                      end: Alignment.bottomRight,
                      colors: [
                        _onClick ? Colors.black45 : Colors.black38,
                        widget.color?.withOpacity(.2) ?? Colors.white,
                        widget.color ?? Colors.white,
                      ],
                      stops: [.0, .5, 1.0],
                    ),
                  ),
                ),
                widget.child,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CircleConvexAnimController {
  CircleConvexAnimController();
  late Function() _onStart;
  late Function() _onReverse;
  _addListener(Function() onStart(), Function() onReverse) {
    this._onStart = onStart;
    this._onReverse = onReverse;
  }

  void onStart() => _onStart();
  void onReverse() => _onReverse();
}
