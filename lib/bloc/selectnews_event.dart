part of 'selectnews_bloc.dart';

abstract class SelectnewsEvent extends Equatable {
  const SelectnewsEvent();

  @override
  List<Object> get props => [];
}

class StartnewsEvent extends SelectnewsEvent {
  final Article article;

  StartnewsEvent({@required this.article});
}

class ClicknewsEvent extends SelectnewsEvent {
  final Article article;

  ClicknewsEvent({@required this.article});
}
