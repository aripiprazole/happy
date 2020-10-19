import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:happy/routes.dart';
import 'package:happy/services/orphanage-service.dart';
import 'package:happy/store/create-orphanage-store.dart';
import 'package:happy/store/orphanages-store.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  final orphanageService = OrphanageService(
    Dio(BaseOptions(baseUrl: const String.fromEnvironment('API_URL'))),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Happy',
      theme: ThemeData(
        primaryColor: const Color(0xff15c3d6),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Provider(
        create: (_) => OrphanagesStore(orphanageService),
        child: Provider(
          create: (_) => CreateOrphanageStore(orphanageService),
          child: Routes(),
        ),
      ),
    );
  }
}
