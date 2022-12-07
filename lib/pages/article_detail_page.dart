import 'package:daily/config/styles/app_color.dart';
import 'package:daily/model/article.dart';
import 'package:flutter/material.dart';

import '../config/assests.dart';
import '../config/text_constance.dart';

class ArticleDetailPageArguments {
  final Article article;

  ArticleDetailPageArguments(this.article);
}

class ArticleDetailPage extends StatefulWidget {
  const ArticleDetailPage({super.key});

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as ArticleDetailPageArguments;
    return Scaffold(
      body: Container(
        color: AppColors.pinkColor,
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context, "HelloWorld");
              },
              icon: Icon(
                Icons.arrow_back,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.error,
              ),
            ),
            if (args.article.source?.id != null)
              Text(args.article.source!.id!)
            else
              Text(
                ArticleDetailPageConstanceText.noArticleSource,
                style: TextStyle(color: Colors.red),
              ),
            Container(child: Text(args.article.title!)),
            const SizedBox(
              height: 50,
            ),
            Text(args.article.description!),
            Image.asset(AppAssets.gdscBackgroundIMG)
          ],
        ),
      ),
    );
  }
}
