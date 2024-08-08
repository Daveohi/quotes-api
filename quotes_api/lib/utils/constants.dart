import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class Constants {
  static String url = 'https://dummyjson.com';
  static String endPoint = '/quotes';

  Future<void> _getQuotes() async {
    final url = Uri.parse(Constants.url + Constants.endPoint);
    final response = await http.get(url);
    final data = json.decode(response.body);

    log('data: $data' as num);

    if (response.statusCode == 200) {
      // final data = json.decode(response.body);
      final Map<String, dynamic> data = json.decode(response.body);
    } else {
      throw Exception('Failed to load quotes.');
    }
  }
}
