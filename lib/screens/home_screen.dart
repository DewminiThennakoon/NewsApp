import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../widgets/news_card.dart';
import 'search_screen.dart';
import 'category_screen.dart';
import 'saved_articles_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'News App',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyanAccent,
        elevation: 4.0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 28),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SearchScreen()),
            ),
            tooltip: 'Search News',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await newsProvider.fetchArticles();
        },
        child: newsProvider.isLoading
            ? const Center(
          child: CircularProgressIndicator(
            color: Colors.cyan,
          ),
        )
            : newsProvider.articles.isEmpty
            ? const Center(
          child: Text(
            'No articles available. Select a category to view articles.',
            style: TextStyle(fontSize: 18, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        )
            : ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          itemCount: newsProvider.articles.length,
          itemBuilder: (context, index) {
            final article = newsProvider.articles[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: NewsCard(article: article),
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.cyan,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'News App',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Daily news',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Categories'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CategoryScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.bookmark),
              title: const Text('Saved Articles'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SavedArticlesScreen()),
              ),
            ),
            const Divider(),
        ListTile(
        title: const Text('About'),
        onTap: () {
    // Show About information (you can customize this as per your requirement)
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('About This App'),
              content: const Text('This app provides the latest news articles from various sources.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
           ),
          );
         },
        ),
       ],
      ),
     ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => newsProvider.fetchArticles(),
        backgroundColor: Colors.cyanAccent,
        child: const Icon(Icons.refresh, size: 28),
        tooltip: 'Refresh News',
      ),
    );
  }
}
