import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happy/screens/create-orphanage/orphanage-data.dart';
import 'package:happy/utils/image.dart';
import 'package:happy/widgets/header.dart';
import 'package:happy/widgets/app-button.dart';

class SelectMapPositionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SelectMapPositionScreenState();
}

class _SelectMapPositionScreenState extends State<SelectMapPositionScreen> {
  LatLng selectedPosition = LatLng(0, 0);
  BitmapDescriptor mapMarker;

  Future<void> onMapCreated(GoogleMapController controller) async {
    final mapMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      MAP_MARKER_ASSET,
    );

    setState(() {
      this.mapMarker = mapMarker;
    });
  }

  @override
  Widget build(BuildContext context) {
    const position = CameraPosition(
      target: const LatLng(-19.966517, -44.1731541),
      zoom: 11.0,
    );

    return Scaffold(
      appBar: Header(title: 'Selecione no mapa'),
      body: Stack(
        children: [
          GoogleMap(
            key: Key('Google map'),
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            markers: mapMarker != null &&
                    selectedPosition.longitude != 0 &&
                    selectedPosition.latitude != 0
                ? Set.of([
                    Marker(
                        markerId: MarkerId("selectedPosition"),
                        icon: mapMarker,
                        position: selectedPosition)
                  ])
                : Set(),
            onMapCreated: onMapCreated,
            onTap: (newPosition) => setState(() {
              selectedPosition = newPosition;
            }),
            initialCameraPosition: position,
          ),
          if (selectedPosition.longitude != 0 && selectedPosition.latitude != 0)
            Positioned(
              left: 24,
              right: 24,
              bottom: 40,
              child: AppButton(
                text: 'Próximo',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => OrphanageDataScreen(
                        position: selectedPosition,
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
