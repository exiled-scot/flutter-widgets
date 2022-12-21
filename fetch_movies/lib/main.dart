import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MoviesApp());

class MoviesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MoviesListing(),
    );
  }
}

class MoviesProvider {
  static final String imagePathPrefix = 'https://image.tmdb.org/t/p/w500/';

  //REPLACE: Replace YOUR_API_KEY with your API key
  static final apiKey = "YOUR_API_KEY";

  static Future<Map> getJson() async {
    final apiEndPoint =
        "http://api.themoviedb.org/3/discover/movie?api_key=${apiKey}&sort_by=popularity.desc";
    final apiResponse = await http.get(Uri.parse(apiEndPoint));
    return json.decode(apiResponse.body);
  }
}

class MoviesListing extends StatefulWidget {
  @override
  _MoviesListingState createState() => _MoviesListingState();
}

class _MoviesListingState extends State<MoviesListing> {
  List<MovieModel> movies = <MovieModel>[];

  //Counter to keep track of netwrok requests
  int counter = 0;

  fetchMovies() async {
    var data = await MoviesProvider.getJson();

    setState(() {
      //Increasing counter here
      counter++;

      List<dynamic> results = data['results'];
      results.forEach((element) {
        movies.add(
          MovieModel.fromJson(element),
        );
      });
    });
  }

  @override
  void initState() {
    super.initState();

    //SOLUTION: Fetch movies data only once.
    fetchMovies();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView.builder(
        itemCount: movies == null ? 0 : movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                MovieTile(movies, index),
                //Widget added to print number of requests made to fetch movies
                Text("Movies fetched: ${counter}"),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MovieTile extends StatelessWidget {
  final List<MovieModel> movies;
  final index;

  const MovieTile(this.movies, this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          movies[index].poster_path != null
              ? Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey,
              image: DecorationImage(
                  image: NetworkImage(MoviesProvider.imagePathPrefix +
                      movies[index].poster_path),
                  fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3.0,
                    offset: Offset(1.0, 3.0)),
              ],
            ),
          )
              : Container(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movies[index].title,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movies[index].overview,
            ),
          ),
          Divider(color: Colors.grey.shade500),
        ],
      ),
    );
  }
}

class MovieModel {
  final int id;
  final num popularity;
  final int vote_count;
  final bool video;
  final String poster_path;
  final String backdrop_path;
  final bool adult;
  final String original_language;
  final String original_title;
  final List<dynamic> genre_ids;
  final String title;
  final num vote_average;
  final String overview;
  final String release_date;

  MovieModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        popularity = json['popularity'],
        vote_count = json['vote_count'],
        video = json['video'],
        poster_path = json['poster_path'],
        adult = json['adult'],
        original_language = json['original_language'],
        original_title = json['original_title'],
        genre_ids = json['genre_ids'],
        title = json['title'],
        vote_average = json['vote_average'],
        overview = json['overview'],
        release_date = json['release_date'],
        backdrop_path = json['backdrop_path'];
}
