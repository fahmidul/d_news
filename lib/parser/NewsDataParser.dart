import 'dart:convert';

import 'package:d_news/models/News.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NewsDataParser {

   Future<News> fetchNewsData() async {
    var url = Uri.parse(
        'http://newsapi.org/v2/top-headlines?country=us&apiKey=6df00bd6eec846ec97d4053de5aad9ce');
    var response = await get(url);
    var jsonData = jsonDecode(response.body);
    News news = News.fromJson(jsonData);
    print(news.status);
    return news;
     // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

  }

   Future<News> fetchPopularNewsData() async {
     var url = Uri.parse(
         'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=6df00bd6eec846ec97d4053de5aad9ce');
     var response = await get(url);
     var jsonData = jsonDecode(response.body);
     News news = News.fromJson(jsonData);
     return news;

   }
}
