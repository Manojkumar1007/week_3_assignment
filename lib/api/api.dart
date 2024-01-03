import 'dart:convert';

import 'package:movies_app/api/constants.dart';
import 'package:http/http.dart' as http;

import '../models/movie.dart';

class Api{
  static const _trendingUrl = 'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apiKey}' ;
  static const _topRatedUrl = 'https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.apiKey}' ;
  static const _nowPlayingUrl = 'https://api.themoviedb.org/3/movie/now_playing?api_key=${Constants.apiKey}' ;

  Future<List<Movie>> getTrendingMovies() async{
    final response = await http.get(Uri.parse(_trendingUrl));
    if(response.statusCode == 200){
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something Happened') ;
    }
  }

  Future<List<Movie>> getTopRatedMovies() async{
    final response = await http.get(Uri.parse(_topRatedUrl));
    if(response.statusCode == 200){
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something Happened') ;
    }
  }

  Future<List<Movie>> getNowPlayingMovies() async{
    final response = await http.get(Uri.parse(_nowPlayingUrl));
    if(response.statusCode == 200){
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something Happened') ;
    }
  }
}