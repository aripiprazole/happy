import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextLabel extends StatelessWidget {
  final String label;

  const TextLabel({Key key, @required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: GoogleFonts.nunito(
          color: const Color(0xff8fa7b3),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
