import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../model/article.dart';

class NewsApiService {
  final Uri endpointURL = Uri.parse(
      "https://newsapi.org/v2/everything?q=apple&from=2022-11-22&to=2022-11-22&sortBy=popularity");

  Future<List<Article>> fetchArticle() async {
    Response response = await http.get(endpointURL,
        headers: {"X-Api-Key": "208d436b4640455c9c6546cbc9965aad"});

    // if (response.statusCode ) {

    // }
    var dataJson = jsonDecode(response.body);
    List articleJson = dataJson["articles"] as List;
    final List<Article> articles = [];
    for (int i = 0; i < articleJson.length; i++) {
      articles.add(Article.fromJson(articleJson[i]));
    }
    // TODO FIX LỖI SERVER
    return articles;
  }
}
