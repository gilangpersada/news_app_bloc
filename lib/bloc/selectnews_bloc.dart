import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:news_app/bloc/news_bloc.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/repositories/news_repository.dart';

part 'selectnews_event.dart';
part 'selectnews_state.dart';

class SelectnewsBloc extends Bloc<SelectnewsEvent, SelectnewsState> {
  // Article article;

  SelectnewsBloc(
      // @required this.article, @required SelectnewsInitialState initialState
      )
      : super(SelectnewsInitialState());

  @override
  Stream<SelectnewsState> mapEventToState(
    SelectnewsEvent event,
  ) async* {
    if (event is StartnewsEvent) {
      try {
        yield SelectnewsInitialState();
        yield SelectnewsLoadedState(article: event.article);
      } catch (e) {
        print(e.toString());
      }
    } else if (event is ClicknewsEvent) {
      print((state as SelectnewsLoadedState).article.title);
      yield SelectnewsLoadedState(article: event.article);
    }
  }
}
