import 'dart:convert';

class NewsAppResponseModel {
  String status;
  String message;
  int totalResults;
  List<Article> articles;

  NewsAppResponseModel({
    required this.status,
    required this.message,
    required this.totalResults,
    required this.articles,
  });

  factory NewsAppResponseModel.fromJson(Map<String, dynamic> json) => NewsAppResponseModel(
        status: json["status"],
        message: json["message"] ?? "",
        totalResults: json["totalResults"],
        articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };

  static NewsAppResponseModel newsAppResponseModelFromJson(String str) => NewsAppResponseModel.fromJson(json.decode(str));

  static String newsAppResponseModelToJson(NewsAppResponseModel data) => json.encode(data.toJson());
}

class Article {
  Source source;
  String? author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String? content;

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json["source"]),
        author: json["author"] ?? "",
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        url: json["url"] ?? "",
        urlToImage: json["urlToImage"] ?? "",
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "source": source.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
      };

  static String encode(List<Article> articleList) => json.encode(
        articleList.map<Map<String, dynamic>>((userData) => userData.toJson()).toList(),
      );

  static List<Article> decode(String articleList) =>
      (json.decode(articleList) as List<dynamic>).map<Article>((item) => Article.fromJson(item)).toList();
}

class Source {
  String? id;
  String name;

  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
