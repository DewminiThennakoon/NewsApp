import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class NewsApiService {
  static const String _baseUrl = 'https://newsapi.org/v2';
  static const String _apiKey = 'f81ac4edef4d4b64b9bf08cb37eac2e5'; //News API key

  Future<List<Article>> fetchArticles({String category = '', String query = ''}) async {
    final String endpoint = category.isNotEmpty
        ? '$_baseUrl/top-headlines?category=$category&apiKey=$_apiKey'
        : query.isNotEmpty
        ? '$_baseUrl/everything?q=$query&apiKey=$_apiKey'
        : '$_baseUrl/top-headlines?apiKey=$_apiKey';

    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['articles'] as List).map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch articles');
    }
  }
}
