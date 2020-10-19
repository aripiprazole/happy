import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy/widgets/text-input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class FileInput extends StatefulWidget {
  final String label;
  final ValueChanged<PickedFile> onChanged;

  const FileInput({Key key, @required this.label, @required this.onChanged})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _FileInputState();
}

class _FileInputState extends State<FileInput> {
  final ImagePicker picker = ImagePicker();

  bool isRequestingImagePicker = false;

  Future<void> handlePickImage() async {
    if (isRequestingImagePicker) return;
    setState(() {
      isRequestingImagePicker = true;
    });

    if (await Permission.photos.request().isDenied) return;

    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    widget.onChanged(pickedFile);

    setState(() {
      isRequestingImagePicker = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: Text(
                widget.label,
                style: GoogleFonts.nunito(
                  color: const Color(0xff8fa7b3),
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 32),
          height: DEFAULT_INPUT_HEIGHT,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Material(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromRGBO(255, 255, 255, 0.5),
            child: LayoutBuilder(builder: (context, constraints) {
              return DottedBorder(
                borderType: BorderType.RRect,
                padding: EdgeInsets.zero,
                color: const Color(0xff96d2f0),
                radius: const Radius.circular(20),
                strokeWidth: 1.4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: MaterialButton(
                    child: Icon(Icons.add),
                    height: 56,
                    minWidth: constraints.maxWidth,
                    onPressed: handlePickImage,
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
