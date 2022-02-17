import '../constants/url_constants.dart';

class Movie {
  int id;
  String image;
  String title;
  String date;
  double rating;

  Movie(
      {required this.id,
      required this.title,
      required this.image,
      required this.date,
      required this.rating});

  Movie.fromJson(Map json)
      : title = json['original_title'],
        image = imageURL + json['poster_path'],
        date = json['release_date'],
        rating = json['vote_average'].toDouble(),
        id = json['id'].toInt();

  static String formatDate(String date) {
    var formattedDate = date.split('-');
    return formattedDate[2] + '.' + formattedDate[1] + '.' + formattedDate[0];
  }
}
