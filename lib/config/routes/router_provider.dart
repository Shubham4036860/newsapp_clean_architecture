import 'package:flutter/material.dart';
import 'package:news_app/config/routes/route_name.dart';
import 'package:news_app/features/presentation/pages/news_detail/ui/news_detail_view.dart';
import 'package:news_app/features/presentation/pages/news_home/ui/news_home_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case newsHome:
        return MaterialPageRoute(builder: (_) => const NewsHomeView());
      case newsDetail:
        return MaterialPageRoute(builder: (BuildContext context) {
          NewsDetailArguments arguments = args as NewsDetailArguments;
          return NewsDetailView(
              title: arguments.title,
              source: arguments.source,
              description: arguments.description,
              imageOFNews: arguments.imageOFNews,
              publishAT: arguments.publishAT,
              contentOfNews: arguments.contentOfNews);
        });
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

class NewsDetailArguments {
  final String title;
  final String source;
  final String description;
  final String imageOFNews;
  final String publishAT;
  final String contentOfNews;

  NewsDetailArguments(this.title, this.source, this.description, this.imageOFNews, this.publishAT, this.contentOfNews);
}
