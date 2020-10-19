import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  final double height;

  const Separator({Key key, this.height = 0.8}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      color: const Color(0xffd3e2e6),
      margin: EdgeInsets.symmetric(vertical: 40),
    );
  }
}
