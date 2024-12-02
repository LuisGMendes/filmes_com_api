class Movie {
  final String title;
  final String posterPath;
  final String overview;
  final String releaseDate;

  Movie({
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'] ?? 'Sem título',
      posterPath: json['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}'
          : '',
      overview: json['overview'] ?? 'Sem sinopse',
      releaseDate: json['release_date'] ?? 'Sem data',
    );
  }
}