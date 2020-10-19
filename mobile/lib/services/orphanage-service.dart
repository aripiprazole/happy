import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:happy/models/orphanage.dart';

class OrphanageService {
  final Dio client;

  OrphanageService(this.client);

  Future<List<Orphanage>> findAllOrphanages() async {
    final response = await client.get<List<dynamic>>('/orphanages');

    return response.data.map((json) => Orphanage.fromJson(json)).toList();
  }

  Future<Orphanage> findOrphanageById(num id) async {
    final response = await client.get<Map<String, dynamic>>('/orphanages/$id');

    return Orphanage.fromJson(response.data);
  }

  // uses multipart request 'cause Dio FormData does not work for unknown reason
  // TODO: use Dio instead of http
  Future<Orphanage> createOrphanage(Map<String, dynamic> data) async {
    final formData = http.MultipartRequest(
      'POST',
      Uri.parse('${client.options.baseUrl}/orphanages'),
    );

    data.forEach((key, value) {
      formData.fields[key] = value.toString();
    });

    // (data['images'] as List<File>)?.forEach((file) {
    //   formData.files
    // });

    final response = await formData.send();
    final body = await response.stream.bytesToString();

    return Orphanage.fromJson(json.decode(body));
  }
}
