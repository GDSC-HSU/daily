import 'package:flutter/material.dart';

import '../../pages/article_detail_page.dart';
import '../../pages/home_page.dart';
import '../../pages/setting_page.dart';
import '../../pages/top_article_page.dart';

class DailyRoute {
  static String home = "/home";
  static String articleDetail = "/articleDetail";
  static String topArticle = "/topArticle";
  static String setting = "/setting";
}

Map<String, Widget Function(BuildContext)> buildRoutes() {
  return {
    DailyRoute.home: (context) =>
        const MyHomePage(title: 'Flutter Impact Daily'),
    DailyRoute.articleDetail: (context) => const ArticleDetailPage(),
    DailyRoute.topArticle: (context) => const TopArticlePage(),
    DailyRoute.setting: (context) => const SettingPage(),
  };
}
