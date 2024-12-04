class Movie {
  final String title;
  final String posterPath;
  final String overview;
  final String releaseDate;
  final double popularity;
  final List<int> genreIds;

  Movie({
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
    required this.popularity,
    required this.genreIds,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'] ?? 'Sem título',
      posterPath: json['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}'
          : '',
      overview: json['overview'] ?? 'Sem sinopse',
      releaseDate: json['release_date'] ?? 'Sem data',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      genreIds: List<int>.from(json['genre_ids'] ?? []),
    );
  }
}
