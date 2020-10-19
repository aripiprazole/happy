import 'package:flutter/material.dart';
import 'package:happy/screens/create-orphanage/select-map-position.dart';
import 'package:happy/screens/home.dart';

class Routes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        MaterialPage(
          key: ValueKey('CreateOrphanage/SelectMapPosition'),
          name: 'create-orphanage/select-map-position',
          child: SelectMapPositionScreen(),
        ),

        MaterialPage(
          key: ValueKey('Home'),
          name: 'home',
          child: HomeScreen(),
        ),
      ],
      onPopPage: (route, result) => result.didPop(result),
    );
  }
}
