import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleWithDescription extends StatelessWidget {
  final String title;
  final String description;

  const TitleWithDescription({
    Key key,
    @required this.title,
    @required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.nunito(
                color: const Color(0xff4d6f80),
                fontWeight: FontWeight.w800,
                fontSize: 30,
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          child: Text(
            description,
            style: GoogleFonts.nunito(
              color: const Color(0xff5c8599),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
