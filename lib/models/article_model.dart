class Article {
  final String title;
  final String description;
  final String urlToImage;
  final String content;


  Article({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.content,

  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      urlToImage: json['urlToImage'] ?? '',
      content: json['content'] ?? 'No Content',

    );
  }
}
