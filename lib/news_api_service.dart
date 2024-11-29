import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsApiService {
  final String _apiKey = '5dd2cccbe9b84a99a9a1394c8e13a726';
  final String _baseUrl = 'https://newsapi.org/v2';

  Future<List<dynamic>> fetchNews({String category = 'general'}) async {
    final url = '$_baseUrl/top-headlines?country=us&category=$category&apiKey=$_apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
