import 'package:flutter/material.dart';

class InfoCard extends StatefulWidget {
  InfoCard({
    Key? key,
    required this.onPressed,
    required this.index,
    this.width,
    this.margin,
    this.header,
    this.body,
    this.dotColor,
  }) : super(key: key);

  final Function(int) onPressed;
  final int index;
  final Widget? header;
  final Widget? body;
  final double? width;
  final double? margin;
  final Color? dotColor;

  @override
  _InfoCardState createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  bool _onClick = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() => _onClick = true);
        await Future.delayed(Duration(milliseconds: 100));
        setState(() => _onClick = false);
        widget.onPressed.call(widget.index);
      },
      onTapUp: (detail) async {
        _onClick = false;
        setState(() {});
        await Future.delayed(Duration(milliseconds: 100));
        widget.onPressed.call(widget.index);
      },
      onTapDown: (detail) {
        _onClick = true;
        setState(() {});
      },
      onTapCancel: () => setState(() => _onClick = false),
      child: Container(
        width: widget.width,
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 7.0),
        margin: EdgeInsets.symmetric(horizontal: widget.margin ?? 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(3.0, 5.0),
              blurRadius: 10.0,
              spreadRadius: 1.0,
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff34393f),
              Color(0xff30353b),
              Color(0xff2b2f34),
              Colors.black,
            ],
            stops: [.0, .1, .2, .9],
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.header ?? SizedBox.shrink(),
                SizedBox(height: 10.0),
                widget.body ?? SizedBox.shrink(),
              ],
            ),
            Positioned(
              left: 0.0,
              bottom: 0.0,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: !_onClick
                      ? widget.dotColor?.withOpacity(.3) ??
                          Colors.blue.withOpacity(.3)
                      : null,
                ),
                child: Container(
                  padding: EdgeInsets.all(1.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.dotColor ?? Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
