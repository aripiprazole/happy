import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy/widgets/text-label.dart';

const DEFAULT_INPUT_HEIGHT = 56.0;

class TextInput extends StatelessWidget {
  final String label;
  final bool multiline;
  final double height;
  final ValueChanged<String> onChanged;

  const TextInput({
    Key key,
    @required this.label,
    @required this.onChanged,
    this.multiline = false,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [TextLabel(label: label)],
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          height: height != null ? height : DEFAULT_INPUT_HEIGHT,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.fromBorderSide(
              BorderSide(width: 1.4, color: const Color(0xffd3e2e6)),
            ),
          ),
          child: TextField(
            style: GoogleFonts.nunito(fontSize: 18),
            keyboardType:
                multiline ? TextInputType.multiline : TextInputType.text,
            maxLines: null,
            onChanged: onChanged,
            decoration: InputDecoration(
              fillColor: Colors.white,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
