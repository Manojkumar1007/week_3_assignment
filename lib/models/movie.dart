class Movie{
  String title;
  String backDropPath;
  String originalTitle;
  String posterPath;
  String overview;
  String releaseDate;
  double voteAverage;

  Movie({
    required this.title,
    required this.backDropPath,
    required this.originalTitle,
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json){
    return Movie(
      title: json['title'],
      backDropPath: json['backdrop_path'],
      originalTitle: json['original_title'],
      posterPath: json['poster_path'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      voteAverage: json['vote_average'] as double,
    );
  }
}

