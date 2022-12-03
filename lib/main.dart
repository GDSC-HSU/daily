import 'dart:convert';

import 'package:daily/blocs/bloc/new_article_bloc.dart';
import 'package:daily/model/article.dart';
import 'package:daily/widgets/card_article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'services/newapi_service.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => NewArticleBloc(),
    child: MyApp(),
  ));
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
  List<Article> articles = [];
  final NewsApiService apiService = NewsApiService();
  @override
  void initState() {
    super.initState();
    // kéo dữ liệu từ API
    // apiService.fetchArticle().then((newArticleValue) {
    //   setState(() {
    //     articles = newArticleValue;
    //   });
    // });
    BlocProvider.of<NewArticleBloc>(context).add(NewArticleLoadEvent());
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
            BlocBuilder<NewArticleBloc, NewArticleState>(
              builder: (context, state) {
                if (state is NewArticleLoading) {
                  return CircularProgressIndicator();
                }

                return Expanded(
                  child: ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) => CardArticle(
                            title: articles[index].title ?? "",
                            description: articles[index].description ?? "",
                            date: articles[index].publishedAt ?? "",
                            imageURL: articles[index].urlToImage ?? "",
                          )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
