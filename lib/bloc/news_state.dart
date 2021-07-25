part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitialState extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadedState extends NewsState {
  final List<Article> articleList;

  NewsLoadedState({@required this.articleList});
}

class NewsErrorState extends NewsState {
  final String error;

  NewsErrorState({@required this.error});
}
