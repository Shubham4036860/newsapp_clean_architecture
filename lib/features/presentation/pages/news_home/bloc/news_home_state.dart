import 'package:news_app/features/data/news_home_entity/news_appresponse_model.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsPageLoading extends NewsState {}

class NewsPageLoaded extends NewsState {
  final NewsAppResponseModel data;

  NewsPageLoaded(this.data);
}

class NewsPageError extends NewsState {
  final String errorMessage;

  NewsPageError(this.errorMessage);
}

class NewsPageOfflineData extends NewsState {
  final NewsAppResponseModel data;

  NewsPageOfflineData(this.data);
}


