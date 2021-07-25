import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news_bloc.dart';
import 'package:news_app/bloc/selectnews_bloc.dart';
import 'package:news_app/models/article.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: width,
        height: height,
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NewsLoadedState) {
              List<Article> _articleList = [];
              _articleList = state.articleList;
              context
                  .read<SelectnewsBloc>()
                  .add(StartnewsEvent(article: state.articleList[0]));

              return ListView(
                scrollDirection: Axis.vertical,
                children: [
                  SizedBox(height: 16),
                  newsSection(width, height, _articleList),
                  SizedBox(height: 16),
                  BlocBuilder<SelectnewsBloc, SelectnewsState>(
                    builder: (context, newsSelect) {
                      if (newsSelect is SelectnewsLoadedState) {
                        return newsDetailSection(
                            width, height, newsSelect.article);
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              );
            } else if (state is NewsErrorState) {
              String error = state.error;
              return Center(
                child: Text(error),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget newsDetailSection(double width, double height, Article newsSelect) {
    return Container(
      color: Colors.white,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Image(
            image: NetworkImage(newsSelect.urlToImage),
            fit: BoxFit.cover,
            width: width,
            height: height / 4,
          ),
          SizedBox(height: 16),
          Text(
            newsSelect.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            newsSelect.description,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Divider(
            height: 24,
            thickness: 1,
            color: Colors.black,
          ),
          Text(
            newsSelect.content,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  Container newsSection(
      double width, double height, List<Article> articleList) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Text(
            'News',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Container(
            width: width,
            height: height / 3,
            child: ListView.builder(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              itemCount: articleList.length,
              itemBuilder: (context, index) =>
                  newsCard(width, height, articleList, index),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget newsCard(
      double width, double height, List<Article> articleList, int index) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      width: width / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey[300],
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image(
              image: NetworkImage(articleList[index].urlToImage),
              fit: BoxFit.cover,
              height: height / 6,
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              articleList[index].title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              articleList[index].description,
              style: TextStyle(
                fontSize: 10,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 16),
              child: Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: GestureDetector(
                  onTap: () {
                    context
                        .read<SelectnewsBloc>()
                        .add(ClicknewsEvent(article: articleList[index]));
                  },
                  child: Text(
                    'See detail',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.blue[900],
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
