import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:movieapplication/constants/url_constants.dart';

class MovieAPI {
  static Future getMovies() {
    return http.get(Uri.parse(mainURL + 'popular' + apiKey));
  }

  static Future getMovie(int id){
    return http.get(Uri.parse(mainURL + id.toString() + apiKey));
  }
}
