import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xff3cdc8c),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: MaterialButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.message, color: Colors.white),
              Container(
                margin: EdgeInsets.only(left: 16),
                child: Text(
                  'Entrar em contato',
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
