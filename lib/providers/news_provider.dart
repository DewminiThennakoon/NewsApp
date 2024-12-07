import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../services/news_api_service.dart';

class NewsProvider with ChangeNotifier {
  final NewsApiService _newsApiService = NewsApiService();

  List<Article> _articles = [];
  List<Article> _bookmarkedArticles = [];
  bool _isLoading = false;

  List<Article> get articles => _articles;
  List<Article> get bookmarkedArticles => _bookmarkedArticles;
  bool get isLoading => _isLoading;

  Future<void> fetchArticles({String category = '', String query = ''}) async {
    _isLoading = true;
    notifyListeners();

    try {
      _articles = await _newsApiService.fetchArticles(category: category, query: query);
    } catch (e) {
      _articles = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void bookmarkArticle(Article article) {
    _bookmarkedArticles.add(article);
    notifyListeners();
  }
}
