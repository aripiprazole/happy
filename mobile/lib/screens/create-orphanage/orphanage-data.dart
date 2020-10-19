import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:happy/store/create-orphanage-store.dart';
import 'package:happy/store/orphanages-store.dart';
import 'package:happy/widgets/file-input.dart';
import 'package:happy/widgets/header.dart';
import 'package:happy/widgets/app-button.dart';
import 'package:happy/widgets/text-input.dart';
import 'package:happy/widgets/text-label.dart';
import 'package:happy/widgets/underlined-title.dart';

class OrphanageDataScreen extends StatefulWidget {
  final LatLng position;

  const OrphanageDataScreen({Key key, @required this.position})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _OrphanageDataScreenState();
}

class _OrphanageDataScreenState extends State<OrphanageDataScreen> {
  String _name = "";
  String _about = "";
  String _instructions = "";
  String _openingHours = "";
  bool _openOnWeekends = false;
  List<PickedFile> _images = [];

  void handleCreateOrphanage(
    CreateOrphanageStore createOrphanageStore,
    OrphanagesStore orphanagesStore,
    BuildContext context,
  ) async {
    final data = {
      'name': _name,
      'about': _about,
      'latitude': widget.position.latitude,
      'longitude': widget.position.longitude,
      'instructions': _instructions,
      'opening_hours': _openingHours,
      'open_on_weekends': _openOnWeekends,
      'images': _images.map((pickedFile) => File(pickedFile.path)),
    };

    orphanagesStore.addOrphanage(
      await createOrphanageStore.createOrphanage(data),
    );

    Navigator.of(context).pushNamed('home');
  }

  Widget _buildImageContainer() {
    return Container(
      height: 78,
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _images.length,
        itemBuilder: (context, index) {
          return Container(
            margin: _images.length - 1 == index
                ? const EdgeInsets.only(right: 10)
                : EdgeInsets.zero,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.file(
                File(_images[index].path),
                height: 78,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final createOrphanageStore = Provider.of<CreateOrphanageStore>(context);
    final orphanagesStore = Provider.of<OrphanagesStore>(context);

    return Scaffold(
      appBar: Header(title: 'Informe os dados'),
      body: Container(
        color: const Color(0xfff0f0f0),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            UnderlinedTitle(title: 'Dados'),
            TextInput(
              label: 'Nome',
              onChanged: (value) => setState(() {
                _name = value;
              }),
            ),
            TextInput(
              label: 'Sobre',
              multiline: true,
              height: 110,
              onChanged: (value) => setState(() {
                _about = value;
              }),
            ),
            Column(
              children: [
                if (_images.length > 0) _buildImageContainer(),
                FileInput(
                  key: Key('images'),
                  label: 'Fotos',
                  onChanged: (value) => setState(() {
                    _images = [..._images, value];
                  }),
                ),
              ],
            ),
            UnderlinedTitle(title: 'Visitação'),
            TextInput(
              label: 'Instruções',
              multiline: true,
              height: 110,
              onChanged: (value) => setState(() {
                _instructions = value;
              }),
            ),
            TextInput(
              label: 'Horario de visitas',
              onChanged: (value) => setState(() {
                _openingHours = value;
              }),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextLabel(label: 'Atende final de semana?'),
                  Switch(
                    value: _openOnWeekends,
                    activeColor: const Color(0xff39cc83),
                    onChanged: (value) => setState(() {
                      _openOnWeekends = value;
                    }),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 32),
              child: AppButton(
                text: 'Cadastrar',
                onPressed: () => handleCreateOrphanage(
                  createOrphanageStore,
                  orphanagesStore,
                  context,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
