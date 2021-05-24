class News {
  String status;
  int totalResults;
  List<Article> articles;

  News({this.status, this.articles});

  News.fromJson(Map<String, dynamic> newsJson)
      : status = newsJson['status'],
        articles = List.from(newsJson['articles'])
            .map((article) => Article.fromJson(article))
            .toList(),
        totalResults = newsJson['totalResults'];
}

class Article {
  String author;
  String title;
  String description;
  String url;
  String content;
  String urlToImage;


  Article(this.author, this.title, this.description, this.url, this.content,
      this.urlToImage);

  Article.fromJson(Map<String, dynamic> articleJson)
      : author = articleJson['author'],
        title = articleJson['title'],
        description = articleJson['description'],
        url = articleJson['url'],
        content = articleJson['content'],
        urlToImage = articleJson['urlToImage'];
}
