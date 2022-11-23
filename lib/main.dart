import 'dart:convert';

import 'package:daily/model/article.dart';
import 'package:daily/widgets/card_article.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Impact Daily'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Uri endpointURL = Uri.parse(
      "https://newsapi.org/v2/everything?q=apple&from=2022-11-22&to=2022-11-22&sortBy=popularity");
  final List<Article> articles = [];

  void fetchArticle() async {
    Response response = await http.get(endpointURL,
        headers: {"X-Api-Key": "208d436b4640455c9c6546cbc9965aad"});

    var dataJson = jsonDecode(response.body);
    List articleJson = dataJson["articles"] as List;

    for (int i = 0; i < articleJson.length; i++) {
      articles.add(Article.fromJson(articleJson[i]));
    }
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    fetchArticle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEBEBEB),
        title: Center(
            child: Text(
          widget.title,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF041A3C)),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 21),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text('News Daily',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF041A3C))),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => CardArticle(
                        title: articles[index].title ?? "",
                        description: articles[index].description ?? "",
                        date: articles[index].publishedAt ?? "",
                        imageURL: articles[index].urlToImage ?? "",
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
