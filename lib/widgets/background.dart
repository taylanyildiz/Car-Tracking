import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  Background({
    Key? key,
    this.child,
  }) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff34393f),
            Color(0xff30353b),
            Color(0xff2b2f34),
            Colors.black,
          ],
          stops: [0.2, 0.4, 0.5, .9],
        ),
      ),
      child: child,
    );
  }
}
