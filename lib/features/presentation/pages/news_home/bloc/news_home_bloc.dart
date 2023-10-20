import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/offlinestorage/offline_storage.dart';
import 'package:news_app/features/data/news_home_entity/news_appresponse_model.dart';
import 'package:news_app/features/data/news_home_repositary/news_app_repositary.dart';
import 'package:news_app/features/presentation/pages/news_home/bloc/news_home_event.dart';
import 'package:news_app/features/presentation/pages/news_home/bloc/news_home_state.dart';
import 'package:news_app/features/presentation/widgets/common_widget_app.dart';

class AppNewsBloc extends Bloc<NewsEvent, NewsState> {
  final _newsRepo = MainNewsAppRepo();
  final secureStorage = SecureStorage();

  AppNewsBloc() : super(NewsInitial()) {
    on<NewsFetchDataEvent>(_fetchNewsList);
  }

  Future<void> _fetchNewsList(NewsEvent event, Emitter<NewsState> emit) async {
    await checkConnectivity().then((value) async {
      if (value == true) {
        if (event is NewsFetchDataEvent) {
          emit(NewsPageLoading());
          await _newsRepo
              .getNewsData(event.countryCode, event.newsType)
              .onError((error, stackTrace) => emit(NewsPageError(error.toString())))
              .then((value) async {
            NewsAppResponseModel newsListMain = NewsAppResponseModel.fromJson(value);
            if (newsListMain.status == "ok") {
              emit(NewsPageLoaded(newsListMain));
              await secureStorage.writeSecureData(secureStorage.appResponseModelKey, NewsAppResponseModel.newsAppResponseModelToJson(newsListMain));
              print("check data is storage or not");
            } else {
              emit(NewsPageError(newsListMain.message));
            }
          });
        }
      } else if (value == false) {
        String value = await secureStorage.readSecureData(secureStorage.appResponseModelKey);
        if (value != "No data found!") {
          NewsAppResponseModel newsAppResponseModel = NewsAppResponseModel.fromJson(jsonDecode(value));
          if (newsAppResponseModel != null) {
            emit(NewsPageOfflineData(newsAppResponseModel));
          }
        } else if (value == "No data found!") {
          emit(NewsPageError("Please Enable Your Internet For First Time Show Data"));
        }
      }
    });
  }
}
