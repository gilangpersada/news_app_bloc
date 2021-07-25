import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news_bloc.dart';
import 'package:news_app/bloc/selectnews_bloc.dart';
import 'package:news_app/repositories/news_repository.dart';
import 'package:news_app/views/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc(
              newsRepository: NewsRepository(),
              initialState: NewsInitialState()),
        ),
        BlocProvider<SelectnewsBloc>(
          create: (context) => SelectnewsBloc(),
        ),
      ],
      child: MaterialApp(
        home: SplashScreen(),
      ),
    );
  }
}
