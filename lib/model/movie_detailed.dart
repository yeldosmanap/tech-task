import '../constants/url_constants.dart';

class MovieDetailed {
  String? title;
  double? rate;
  String? date;
  String? image;
  String? background;
  String? description;
  List<String>? genres;
  int? revenue;
  int? duration;

  MovieDetailed(this.title, this.rate, this.date,
      this.image, this.background, this.description,
      this.genres, this.revenue, this.duration);
  MovieDetailed.fromJson(Map json)
      : title = json['original_title'],
        rate = json['vote_average'].toDouble(),
        date = json['release_date'],
        duration = json['runtime'],
        revenue = json['revenue'],
        image = imageURL + json['poster_path'],
        background = imageBackgroundURL + json['backdrop_path'],
        genres = List.from((json['genres']).map((element) => element['name']).toList()),
        description = json['overview'];

  static String formatDate(String date) {
    var formattedDate = date.split('-');
    return formattedDate[2] + '.' + formattedDate[1] + '.' + formattedDate[0];
  }

  static String formatDuration(int duration){
    int hours = duration ~/ 60.0;
    int remainder = duration % 60;
    if(hours == 1){
      return '$hours час $remainder мин';
    }
    else if(hours >= 2 && hours <= 4){
      return '$hours часа $remainder мин';
    }
    else{
      return '$hours часов $remainder мин';
    }
  }

  static String formatRevenue(int revenue){
    String formattedRevenue = '';
    for(int i = 0; i < revenue.toString().length; i++){
      if( (revenue.toString().length - i) % 3 == 0 && i != 0){
        formattedRevenue += ' ';
      }
      formattedRevenue += revenue.toString()[i];
    }
    return formattedRevenue + ' \$';
  }

  String? formatGenres(){
    String? str = genres?.join(', ');
    return str;
  }
}
