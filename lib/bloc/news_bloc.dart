import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/repositories/news_repository.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsRepository newsRepository;
  NewsBloc(
      {@required this.newsRepository, @required NewsInitialState initialState})
      : super(initialState) {
    add(StartEvent());
  }

  @override
  Stream<NewsState> mapEventToState(
    NewsEvent event,
  ) async* {
    if (event is StartEvent) {
      try {
        List<Article> _articleList = [];
        yield NewsLoadingState();
        _articleList = await newsRepository.fetchNews();

        yield NewsLoadedState(articleList: _articleList);
      } catch (e) {
        yield NewsErrorState(error: e.toString());
      }
    }
  }
}
