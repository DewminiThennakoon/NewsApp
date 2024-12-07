import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../widgets/news_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Articles',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.cyanAccent,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search TextField with enhanced styling
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blueAccent),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Enter keyword',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search, color: Colors.blueAccent),
                    onPressed: () {
                      final query = _searchController.text;
                      if (query.isNotEmpty) {
                        newsProvider.fetchArticles(query: query);
                      }
                    },
                  ),
                ),
                onSubmitted: (query) {
                  if (query.isNotEmpty) {
                    newsProvider.fetchArticles(query: query);
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            // Display search results or loading spinner
            Expanded(
              child: newsProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : newsProvider.articles.isEmpty
                  ? const Center(child: Text('No articles found'))
                  : ListView.builder(
                itemCount: newsProvider.articles.length,
                itemBuilder: (context, index) {
                  final article = newsProvider.articles[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: NewsCard(article: article),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
