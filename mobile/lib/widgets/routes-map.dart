import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class RoutesMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const position = CameraPosition(
      target: LatLng(-19.966517, -44.1731541),
      zoom: 11.0,
    );

    return Container(
      margin: const EdgeInsets.only(top: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xffe6f7fb),
        border: Border.all(
          width: 1.2,
          color: const Color(0xffb2dae2),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: const Radius.circular(20),
              ),
              child: GoogleMap(
                key: Key('Google map'),
                mapType: MapType.normal,
                zoomControlsEnabled: false,
                scrollGesturesEnabled: false,
                onMapCreated: (controller) {},
                initialCameraPosition: position,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                'Ver rotas no google map',
                style: GoogleFonts.nunito(
                  color: const Color(0xff0089a5),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
