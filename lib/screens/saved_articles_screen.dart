import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../widgets/news_card.dart';

class SavedArticlesScreen extends StatelessWidget {
  const SavedArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Articles',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.cyanAccent,
        elevation: 4.0,
      ),
      body: newsProvider.bookmarkedArticles.isEmpty
          ? const Center(
        child: Text('No saved articles yet!'),
      )
          : ListView.builder(
        itemCount: newsProvider.bookmarkedArticles.length,
        itemBuilder: (context, index) {
          final article = newsProvider.bookmarkedArticles[index];
          return NewsCard(article: article);
        },
      ),
    );
  }
}
