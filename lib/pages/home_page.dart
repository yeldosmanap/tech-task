import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movieapplication/api/movie_api.dart';
import 'package:movieapplication/model/movie.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Movie> movieList = <Movie>[];
  String optionValue = 'По названию';
  bool loading = true;

  List<String> options = <String>[
    'По названию',
    'По дате выхода',
    'По рейтингу'
  ];

  @override
  void initState() {
    super.initState();
    getMoviesFromAPI();
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
        : Scaffold(
            backgroundColor: const Color(0xFF15141F),
            body: Stack(
              children: [
                SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                'Фильмы',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0,
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  child: InkWell(
                                    onTap: () {},
                                    child: DropdownButton<String>(
                                      value: optionValue,
                                      underline: Container(height: 0),
                                      icon: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Icon(Icons.swap_vert,
                                            size: 19.0, color: Colors.white),
                                      ),
                                      dropdownColor:
                                          Color.fromRGBO(255, 255, 255, 0.85),
                                      selectedItemBuilder:
                                          (BuildContext context) {
                                        return options.map((String value) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              optionValue,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Rubik',
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          );
                                        }).toList();
                                      },
                                      items: options
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: value == optionValue
                                                ? TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w900,
                                                    fontFamily: 'Rubik',
                                                    fontSize: 17.0,
                                                  )
                                                : TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Rubik',
                                                    fontSize: 17.0,
                                                  ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          optionValue = newValue!;
                                          sortMovieList(optionValue);
                                        });
                                      },
                                    ),
                                  ),
                                  color: const Color(0xFF2C2B35),
                                  width: 160.0,
                                  height: 34.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        GridView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: movieList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 270.0,
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  loading = true;
                                });

                                _onMovieTap(movieList[index].id);
                              },
                              child: Container(
                                padding: EdgeInsets.all(9.0),
                                width: widthScreen * 0.443,
                                height: heightScreen * 0.264,
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(17)),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                movieList[index].image),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Container(
                                        padding: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.transparent,
                                              Colors.transparent,
                                              Colors.black
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            stops: [0, 0.8, 0.93],
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  width: 40.0,
                                                  height: 40.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF111015),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                CircularStepProgressIndicator(
                                                  totalSteps: 100,
                                                  stepSize: 10,
                                                  currentStep:
                                                      (movieList[index].rating *
                                                              10)
                                                          .toInt(),
                                                  selectedStepSize: 4,
                                                  unselectedColor:
                                                      Color(0xFF111015),
                                                  selectedColor: Colors.white,
                                                  width: 40.5,
                                                  height: 40.5,
                                                  padding: 0,
                                                  roundedCap: (_, __) => true,
                                                ),
                                                Text(
                                                  movieList[index]
                                                      .rating
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
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Text(
                                                  movieList[index].title,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.0,
                                                    fontFamily: 'Rubik',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Text(
                                                  Movie.formatDate(
                                                      movieList[index].date),
                                                  style: TextStyle(
                                                    color: Color(0xFFBBBBBD),
                                                    fontSize: 12.0,
                                                    fontFamily: 'Rubik',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 3.0,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  void sortMovieList(String option) {
    setState(() {
      switch (option) {
        case 'По названию':
          movieList.sort((a, b) {
            return a.title.toLowerCase().compareTo(b.title.toLowerCase());
          });
          break;
        case 'По дате выхода':
          movieList.sort((a, b) {
            return a.date.compareTo(b.date);
          });
          break;
        case 'По рейтингу':
          movieList.sort((a, b) {
            return b.rating.compareTo(a.rating);
          });
          break;
      }
    });
  }

  void getMoviesFromAPI() async {
    MovieAPI.getMovies().then((response) {
      setState(() {
        Iterable list = jsonDecode(response.body)['results'];
        movieList = list.map((model) => Movie.fromJson(model)).toList();
        loading = false;
      });
    });
  }

  void _onMovieTap(int movieId) async {
    setState(() {
      loading = false;
    });

    Navigator.pushNamed(context, '/movie_info', arguments: movieId);
  }
}
