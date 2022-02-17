import 'package:flutter/material.dart';
import 'package:movieapplication/model/movie_detailed.dart';
import 'package:movieapplication/pages/movie_info_page.dart';
import 'package:movieapplication/pages/home_page.dart';
import '../pages/error_handling_page.dart';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => MyHomePage());
    case '/movie_info':
      return MaterialPageRoute(
          builder: (context) => MovieInfo(movieId: settings.arguments as int));
    default:
      return MaterialPageRoute(builder: (context) => ErrorPage());
  }
}
