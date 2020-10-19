import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduleItem extends StatelessWidget {
  final Widget icon;
  final String text;
  final Color borderColor;
  final Color color;

  const ScheduleItem({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.borderColor,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * (42 / 100),
        height: 180,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: borderColor),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [icon],
            ),
            Container(
              margin: const EdgeInsets.only(top: 24),
              child: Text(
                text,
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
