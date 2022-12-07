import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../config/env/enpoint.dart';
import '../model/article.dart';

class NewsApiService {
  final Uri endpointURL = Uri.parse(
      "${Endpoint.articleEveryThing}?q=apple&from=2022-11-22&to=2022-11-22&sortBy=popularity");

  Future<List<Article>> fetchArticle() async {
    try {
      Response response = await http.get(endpointURL,
          headers: {"X-Api-Key": "208d436b4640455c9c6546cbc9965aad"});
      var dataJson = jsonDecode(response.body);
      List articleJson = dataJson["articles"] as List;
      final List<Article> articles = [];
      for (int i = 0; i < articleJson.length; i++) {
        articles.add(Article.fromJson(articleJson[i]));
      }
      // TODO FIX LỖI SERVER
      return articles;
    } catch (e) {
      print(e);
      // please shutdown your wifi
      throw "NetworkDown";
    }
  }

  Future<List<Article>> fetchTopArticle() async {
    try {
      final Uri endpointTopArticleURL = Uri.parse(
          "https://newsapi.org/v2/top-headlines?q=apple&from=2022-11-22&to=2022-11-22&sortBy=popularity");
      Response response = await http.get(endpointTopArticleURL,
          headers: {"X-Api-Key": "208d436b4640455c9c6546cbc9965aad"});
      var dataJson = jsonDecode(response.body);
      List articleJson = dataJson["articles"] as List;
      final List<Article> articles = [];
      for (int i = 0; i < articleJson.length; i++) {
        articles.add(Article.fromJson(articleJson[i]));
      }
      // TODO FIX LỖI SERVER
      return articles;
    } catch (e) {
      print(e);
      // please shutdown your wifi
      throw "NetworkDown";
    }
  }
}
