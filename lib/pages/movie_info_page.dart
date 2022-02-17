import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movieapplication/api/movie_api.dart';
import 'package:movieapplication/model/movie_detailed.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../model/movie.dart';

class MovieInfo extends StatefulWidget {
  final int movieId;

  const MovieInfo({Key? key, required this.movieId}) : super(key: key);

  @override
  _MovieInfoState createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  late MovieDetailed movie;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    loading = true;
    loadMovieData(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return loading
        ? Center(
            child: SizedBox(
              width: widthScreen * 0.076,
              height: heightScreen * 0.038,
              child: CircularProgressIndicator(),
            ),
          )
        : SafeArea(
            child: Scaffold(
              backgroundColor: Color(0xFF15141F),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: heightScreen * 0.35,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(movie.background!),
                          opacity: 0.09,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: widthScreen * 0.05,
                                left: widthScreen * 0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: widthScreen * 0.1,
                                  height: widthScreen * 0.1,
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                      size: 16.0,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SafeArea(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: widthScreen * 0.0127),
                                      child: Text(
                                        movie.title!,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'Rubik',
                                          fontSize: 24.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: heightScreen * 0.0128),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.056,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    movie.image!,
                                    height: heightScreen * 0.2365,
                                    width: widthScreen * 0.396,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Stack(
                                    children: [
                                      SizedBox(
                                        width: 110.0,
                                        height: 37.0,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Stack(
                                              children: [
                                                Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Container(
                                                      width:
                                                          widthScreen * 0.094,
                                                      height:
                                                          widthScreen * 0.094,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFF111015),
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        right: widthScreen *
                                                            0.02546,
                                                      ),
                                                      child: Text(
                                                        '18',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Rubik',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        left: widthScreen *
                                                            0.0458,
                                                      ),
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                        size: 17.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  width: widthScreen * 0.094,
                                                  height: widthScreen * 0.094,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF111015),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                CircularStepProgressIndicator(
                                                  totalSteps: 100,
                                                  stepSize: 10,
                                                  currentStep:
                                                      (movie.rate! * 10)
                                                          .toInt(),
                                                  selectedStepSize: 3,
                                                  unselectedColor:
                                                      Color(0xFF111015),
                                                  selectedColor: Colors.white,
                                                  width:
                                                      widthScreen * 0.094 + 0.5,
                                                  height:
                                                      widthScreen * 0.094 + 0.5,
                                                  padding: 0,
                                                  roundedCap: (_, __) => true,
                                                ),
                                                Text(
                                                  movie.rate
                                                      .toString()
                                                      .replaceAll('.', ','),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Rubik',
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: heightScreen * 0.0128),
                                  Text(
                                    'Дата выхода:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Rubik',
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  Text(
                                    Movie.formatDate(movie.date!)
                                        .replaceAll('-', '.'),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Rubik',
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  SizedBox(height: heightScreen * 0.0128),
                                  Text(
                                    MovieDetailed.formatDuration(
                                        movie.duration!),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Rubik',
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  SizedBox(height: heightScreen * 0.0128),
                                  Text(
                                    'Доход',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Rubik',
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  Text(
                                    MovieDetailed.formatRevenue(movie.revenue!),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Rubik',
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: heightScreen * 0.038),
                    Column(
                      children: [
                        SizedBox(
                          width: widthScreen * 0.873,
                          height: heightScreen * 0.027,
                          child: Text(
                            'О фильме',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Rubik',
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        SizedBox(height: heightScreen * 0.0128),
                        SizedBox(
                          width: widthScreen * 0.873,
                          height: heightScreen * 0.0256,
                          child: Text(movie.genres!.join(', '),
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.6),
                                fontFamily: 'Rubik',
                                fontSize: 17.0,
                              )),
                        ),
                        SizedBox(height: 10.0),
                        SizedBox(
                          width: widthScreen * 0.873,
                          height: heightScreen * 0.4048,
                          child: Text(
                            movie.description!,
                            style:
                                TextStyle(color: Colors.white, fontSize: 17.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  void loadMovieData(int id) async {
    MovieAPI.getMovie(id).then((value) {
      setState(() {
        movie = MovieDetailed.fromJson(jsonDecode(value.body));

        setState(() {
          loading = false;
        });
      });
    });
  }
}
