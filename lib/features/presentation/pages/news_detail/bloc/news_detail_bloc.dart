import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/presentation/pages/news_detail/bloc/news_detail_event.dart';
import 'package:news_app/features/presentation/pages/news_detail/bloc/news_detail_state.dart';

class NewsDetailBloc extends Bloc<NewsDetailEvent, NewsDetailState> {
  NewsDetailBloc() : super(NewsDetailStateDetailInitial()) {
   /* on<NewsDetailEvent>();*/
  }
}
