import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/appfonts/app_fonts.dart';
import 'package:news_app/config/routes/route_name.dart';
import 'package:news_app/config/routes/router_provider.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/core/offlinestorage/offline_storage.dart';
import 'package:news_app/features/data/news_home_entity/news_appresponse_model.dart';
import 'package:news_app/features/presentation/pages/news_home/bloc/news_home_bloc.dart';
import 'package:news_app/features/presentation/pages/news_home/bloc/news_home_event.dart';
import 'package:news_app/features/presentation/pages/news_home/bloc/news_home_state.dart';
import 'package:news_app/features/presentation/widgets/common_widget_app.dart';

class NewsHomeView extends StatefulWidget {
  const NewsHomeView({super.key});

  @override
  State<NewsHomeView> createState() => _NewsHomeViewState();
}

class _NewsHomeViewState extends State<NewsHomeView> {
  AppNewsBloc? _newsBloc;
  String selectedCountries = "in";
  String newsType = "";
  final List<Article> _newsList = [];

  @override
  void initState() {
    _newsBloc = BlocProvider.of(context);
    _newsBloc?.add(NewsFetchDataEvent(selectedCountries, newsType));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        appBar: getAppBarCommon(
          context,
          Text(
            'News App',
            style: CustomTextStyles.mediumText(color: colorBlue, fontSize: 22),
          ),
        ),
        body: BlocConsumer<AppNewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsPageLoading) {
              return getCenterLoadingView();
            } else if (state is NewsPageError) {
              print("object  state.errorMessage ===>${state.errorMessage}");
              Future.delayed(const Duration(seconds: 1), () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              });
            } else if (state is NewsPageLoaded) {
              if (state.data.articles.isNotEmpty) {
                _newsList.addAll(state.data.articles);
              } else {
                return noDataFound();
              }
            } else if (state is NewsPageOfflineData) {
              if (state.data.articles.isNotEmpty) {
                _newsList.addAll(state.data.articles);
              } else {
                return noDataFound();
              }
            }
            return listOfNews(context);
          },
          listener: (context, state) {
            if (state is NewsPageLoading) {
              getCenterLoadingView();
            } else if (state is NewsPageError) {
              Future.delayed(const Duration(seconds: 1), () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              });
            } else if (state is NewsPageLoaded) {
              if (state.data.articles.isNotEmpty) {
                _newsList.addAll(state.data.articles);
                print("object======>${_newsList.length}");
              } else {
                noDataFound();
              }
            }
            listOfNews(context);
          },
        ),
      ),
    );
  }

  Widget listOfNews(BuildContext context) {
    return _newsList.isEmpty
        ? noDataFound()
        : ListView.builder(
            itemCount: _newsList.length,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  Navigator.pushNamed(context, newsDetail,
                      arguments: NewsDetailArguments(
                        _newsList[index].title,
                        _newsList[index].source.name,
                        _newsList[index].description,
                        _newsList[index].urlToImage,
                        _newsList[index].publishedAt.toString(),
                        _newsList[index].content.toString(),
                      ));
                },
                leading: Container(
                  height: 150,
                  width: 120,
                  decoration: const BoxDecoration(shape: BoxShape.rectangle),
                  child: getNetworkImageView(_newsList[index].urlToImage, boxFit: BoxFit.contain),
                ),
                title: Text(
                  _newsList[index].title,
                  maxLines: 3,
                  style: CustomTextStyles.boldText(color: colorBlack, fontSize: 12),
                ),
                subtitle: Text(
                  _newsList[index].author ?? "",
                  style: CustomTextStyles.mediumText(color: colorBlack, fontSize: 8),
                ),
              );
            });
  }
}
