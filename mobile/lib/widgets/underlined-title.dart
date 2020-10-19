import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UnderlinedTitle extends StatelessWidget {
  final String title;

  const UnderlinedTitle({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 24),
      margin: const EdgeInsets.only(bottom: 32),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.8,
            color: const Color(0xffd3e2e6),
          ),
        ),
      ),
      child: Text(
        title,
        style: GoogleFonts.nunito(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: const Color(0xff5c8599),
        ),
      ),
    );
  }
}
