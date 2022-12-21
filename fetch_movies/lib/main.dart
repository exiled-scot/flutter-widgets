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

  fetchMovies() async {
    var data = await MoviesProvider.getJson();

    setState(() {
      List<dynamic> results = data['results'];

      //Creating list of MovieModel objects
      results.forEach((element) {
        movies.add(
          MovieModel.fromJson(element),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchMovies();

    return Scaffold(
      body: ListView.builder(
        //Calculating list size
        itemCount: movies == null ? 0 : movies.length,
        //Building list view entries
        itemBuilder: (context, index) {
          return Padding(
            //Padding around the list item
            padding: const EdgeInsets.all(8.0),
            //UPDATED CODE: Using MovieTile object to render movie's title, description and image
            child: MovieTile(movies, index),
          );
        },
      ),
    );
  }
}

//NEW CODE: MovieTile object to render visually appealing movie information
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
          //Resizing image poster based on the screen size whenever image's path is not null.
//Resizing image poster based on the screen size whenever the image's path is not null.
          movies[index].poster_path != null
              ? Container(
            //Making image's width to half of the given screen size
            width: MediaQuery.of(context).size.width / 2,

            //Making image's height to one fourth of the given screen size
            height: MediaQuery.of(context).size.height / 4,

            //Making image box visually appealing by dropping shadow
            decoration: BoxDecoration(
              //Making image box slightly curved
              borderRadius: BorderRadius.circular(10.0),
              //Setting box's color to grey
              color: Colors.grey,

              //Decorating image
              image: DecorationImage(
                  image: NetworkImage(MoviesProvider.imagePathPrefix +
                      movies[index].poster_path),
                  //Image getting all the available space
                  fit: BoxFit.cover),

              //Dropping shadow
              boxShadow: [
                BoxShadow(
                  //grey colored shadow
                    color: Colors.grey,
                    //Applying softening effect
                    blurRadius: 3.0,
                    //move 1.0 to right (horizontal), and 3.0 to down (vertical)
                    offset: Offset(1.0, 3.0)),
              ],
            ),
          )
              : Container(), //Empty container when image is not available
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
          //Styling movie's description text
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

//MovielModel object
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