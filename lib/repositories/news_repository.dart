import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/article.dart';

class NewsRepository {
  Future<List<Article>> fetchNews() async {
    var response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?domains=wsj.com&apiKey=b912cad332244d59a763d938e464c14a'));

    if (response.statusCode == 200) {
      List data = json.decode(response.body)['articles'];

      return data.map<Article>((item) => Article.fromJson(item)).toList();
    } else {
      throw Exception('Error in fetching api!');
    }
  }
}
