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
    create: (context) => NewArticleBloc(apiService: NewsApiService()),
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
  final NewsApiService apiService = NewsApiService();
  @override
  void initState() {
    super.initState();

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
            BlocConsumer<NewArticleBloc, NewArticleState>(
              listener: (context, state) {
                if (state is NewArticleLoadFailure) {
                  _showMyDialog();
                }
              },
              builder: (context, state) {
                if (state is NewArticleLoadSusessfully) {
                  final articles = state.articles;
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        BlocProvider.of<NewArticleBloc>(context)
                            .add(NewArticleLoadEvent());
                      },
                      child: ListView.builder(
                          itemCount: articles.length,
                          itemBuilder: (context, index) => CardArticle(
                                title: articles[index].title ?? "",
                                description: articles[index].description ?? "",
                                date: articles[index].publishedAt ?? "",
                                imageURL: articles[index].urlToImage ?? "",
                              )),
                    ),
                  );
                }
                return const Expanded(
                    child: Center(child: CircularProgressIndicator()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Fail to load news'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Would you like reload?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                BlocProvider.of<NewArticleBloc>(context)
                    .add(NewArticleLoadEvent());
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
