import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class Api {
  Api._();

  static const baseUrl = 'universities.hipolabs.com';

  static Future<List<dynamic>> searchForUniversitiesByCountry(
    final String country,
  ) async {
    final queryParameters = {'country': country};
    final uri = Uri.http(
      baseUrl,
      'search',
      queryParameters,
    );
    final response = await http.get(uri);
    return jsonDecode(response.body);
  }
}
