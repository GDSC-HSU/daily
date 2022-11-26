import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../model/article.dart';
import 'article_card.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late ScrollController scrollController;
  // final apiKey = dotenv.env['API_KEY'];
  final List<Article> articles = [];

  int currentPage = 1;
  bool isLoading = false;

  fecthArticle({bool isRefresh = false}) async {
    setState(() {
      isLoading = true;
    });

    if (isRefresh) {
      currentPage = 1;
      articles.clear();
    }

    Uri apiURL = Uri.parse(
        "https://newsapi.org/v2/everything?q=apple&from=2022-11-22&to=2022-11-22&sortBy=popularity&page=$currentPage&pageSize=6");

    Response res = await http.get(
      apiURL,
      headers: {"X-Api-Key": "208d436b4640455c9c6546cbc9965aad"},
    );

    var data = jsonDecode(res.body);
    List listArticle = data['articles'] as List;

    for (final article in listArticle) {
      final Article articleFromJson = Article.fromJson(article);
      articles.add(articleFromJson);
    }

    setState(() {
      isLoading = false;
      currentPage++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();
    fecthArticle();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent * 0.95 &&
          !isLoading) {
        fecthArticle();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFEBEBEB),
          title: const Center(
            child: Text(
              "Flutter Impact Daily",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF041A3C)),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "News Daily",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF041A3C),
                    fontSize: 20,
                  ),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    fecthArticle(isRefresh: true);
                  },
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: articles.isEmpty ? 1 : articles.length,
                    itemBuilder: (context, index) {
                      if (articles.isEmpty) {
                        return const Text("Almost done...");
                      }

                      if (index == articles.length) {
                        return const SizedBox(
                          width: 60,
                          height: 60,
                          child: FittedBox(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return ArticleCard(
                        title: articles[index].title ?? "",
                        description: articles[index].description ?? "",
                        publishedAt: articles[index].publishedAt ?? "",
                        author: articles[index].author ?? "",
                        urlToImage: articles[index].urlToImage ?? "",
                        content: articles[index].content ?? "",
                      );
                    },
                  ),
                ),
              ),
              // ListView.builder(
              //   itemCount: 4,
              //   itemBuilder: )
            ],
          ),
        ),
      ),
    );
  }
}
