import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy/screens/home.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showCancel;

  @override
  final Size preferredSize;

  Header({Key key, @required this.title, this.showCancel = true})
      : preferredSize = Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
        color: const Color(0xfff9fafc),
        border: Border(
          bottom: BorderSide(width: 1, color: Color(0xffdde3f0)),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, size: 24),
                    color: const Color(0xff15b6d6),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ),
                Text(
                  title,
                  style: GoogleFonts.nunito(
                    color: const Color(0xff8fa7b3),
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                if (showCancel)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.close, size: 24),
                      color: const Color(0xffff669d),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                    ),
                  )
                else
                  Container(width: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
