part of 'selectnews_bloc.dart';

abstract class SelectnewsState extends Equatable {
  const SelectnewsState();

  @override
  List<Object> get props => [];
}

class SelectnewsInitialState extends SelectnewsState {
  // final Article article;

  // SelectnewsInitialState({@required this.article});
}

class SelectnewsLoadedState extends SelectnewsState {
  final Article article;

  SelectnewsLoadedState({@required this.article});
  @override
  List<Object> get props => [article];
}
