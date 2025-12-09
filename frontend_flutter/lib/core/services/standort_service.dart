// lib/core/services/standort_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/standort_model.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class StandortService {
  static Future<List<Standort>> fetchStandorte(int kundenId) async {
    final url = Uri.parse(
      'http://192.168.0.108:8000/standorte/kunde/$kundenId/',
    );
    final response = await http.get(url);

    logger.e("HTTP Status: ${response.statusCode}");
    logger.e("Antwort: ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Standort.fromJson(json)).toList();
    } else {
      throw Exception('Fehler beim Laden der Standorte: ${response.body}');
    }
  }
}
