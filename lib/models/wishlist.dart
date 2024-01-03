import 'package:flutter/material.dart';

import 'movie.dart';

class Wishlist extends ChangeNotifier{
  // final Movie movie;

  List<Movie> _wishlist= [] ;

  List<Movie> get wishlist => _wishlist ;

  void addMovieToWishlist(Movie movie){
    _wishlist.add(movie);
    notifyListeners();
  }

  void removeMovieFromWishlist(Movie movie){
    _wishlist.remove(movie);
    notifyListeners();
  }
}