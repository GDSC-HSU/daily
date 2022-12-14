import 'package:daily/blocs/bloc/new_article_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/routes/app_route.dart';
import 'pages/home_page.dart';
import 'services/newapi_service.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => NewArticleBloc(apiService: NewsApiService()),
    child: const MyApp(),
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
      routes: buildRoutes(),
    );
  }
}
