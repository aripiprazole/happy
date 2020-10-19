import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happy/models/orphanage.dart';
import 'package:happy/screens/orphanage-details.dart';
import 'package:happy/store/orphanages-store.dart';
import 'package:happy/utils/image.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BitmapDescriptor mapMarker;
  Orphanage currentOrphanageInfo;
  int currentOrphanageInfoX;
  int currentOrphanageInfoY;

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
  void initState() {
    super.initState();

    final orphanagesStore = Provider.of<OrphanagesStore>(
      context,
      listen: false,
    );

    orphanagesStore.fetchOrphanages();
  }

  @override
  Widget build(BuildContext context) {
    final orphanagesStore = Provider.of<OrphanagesStore>(context);

    const target = LatLng(-19.966517, -44.1731541);
    const position = CameraPosition(
      target: target,
      zoom: 11.0,
    );

    return Scaffold(
      key: Key('Home'),
      body: Observer(builder: (_) {
        return Stack(
          children: [
            Container(
              key: Key('Container google map'),
              child: GoogleMap(
                key: Key('Google map'),
                mapType: MapType.normal,
                zoomControlsEnabled: false,
                markers: orphanagesStore.orphanages.map((orphanage) {
                  return Marker(
                    markerId: MarkerId(orphanage.id.toString()),
                    icon: mapMarker,
                    infoWindow: InfoWindow(
                      title: orphanage.name,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => OrphanageDetailsScreen(
                            orphanage: orphanage,
                          ),
                        ),
                      ),
                    ),
                    position: LatLng(
                      orphanage.latitude.toDouble(),
                      orphanage.longitude.toDouble(),
                    ),
                  );
                }).toSet(),
                onMapCreated: onMapCreated,
                initialCameraPosition: position,
              ),
            ),
            Footer(amount: orphanagesStore.orphanages.length)
          ],
        );
      }),
    );
  }
}

class Footer extends StatelessWidget {
  final int amount;

  const Footer({Key key, @required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 24,
      left: 24,
      bottom: 40,
      child: Material(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.only(left: 20),
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(3, 3),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$amount orfanatos encontrados',
                style: GoogleFonts.nunito(
                  fontSize: 14,
                  color: const Color(0xff8fa7b3),
                  fontWeight: FontWeight.w800,
                  decoration: TextDecoration.none,
                ),
              ),
              MaterialButton(
                child: Icon(Icons.add, color: Colors.white),
                height: 56,
                minWidth: 56,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: const Color(0xff15c3d6),
                onPressed: () => Navigator.of(context).pushNamed(
                  'create-orphanage/select-map-position',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
