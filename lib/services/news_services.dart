import 'dart:io';

import 'package:dio/dio.dart';
import 'package:news_app/enums/categories.dart';
import 'package:news_app/models/news_model.dart';

class NewsServices {
  final dio = Dio();
  Future<List<News>>? future;
  NewsServices._();
  static final instance = NewsServices._();
  void setupNewNews(Categories category) {
    future = getNews(category);
  }

  Future<List<News>> getNews(Categories category) async {
    return await switch (category) {
      Categories.general => getNewsResponse(
          'https://newsapi.org/v2/top-headlines?country=us&apiKey=1fff6f5c91084b2fa4afef3def644b73'),
      Categories.sports => getNewsResponse(
          'https://newsapi.org/v2/top-headlines?category=sports&country=us&apiKey=1fff6f5c91084b2fa4afef3def644b73'),
      Categories.entertainment => getNewsResponse(
          'https://newsapi.org/v2/top-headlines?category=entertainment&country=us&apiKey=1fff6f5c91084b2fa4afef3def644b73'),
      Categories.business => getNewsResponse(
          'https://newsapi.org/v2/top-headlines?category=business&country=us&apiKey=1fff6f5c91084b2fa4afef3def644b73'),
      Categories.health => getNewsResponse(
          'https://newsapi.org/v2/top-headlines?category=health&country=us&apiKey=1fff6f5c91084b2fa4afef3def644b73'),
      Categories.science => getNewsResponse(
          'https://newsapi.org/v2/top-headlines?category=science&country=us&apiKey=1fff6f5c91084b2fa4afef3def644b73'),
      Categories.technology => getNewsResponse(
          'https://newsapi.org/v2/top-headlines?category=technology&country=us&apiKey=1fff6f5c91084b2fa4afef3def644b73'),
    };
  }

  Future<List<News>> getNewsResponse(String link) async {
    try {
      final response = await dio.get(
        link,
      );
      if (response.statusCode != HttpStatus.ok) {
        return List.empty();
      }
      List articles = response.data['articles'];
      List<News> data = articles.map((e) =>News.fromJson(e)).toList();
      return data;
    } catch (e) {
      return List.empty();
    }
  }
}
