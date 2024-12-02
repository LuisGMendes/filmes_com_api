import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'movie.dart';

class MovieProvider with ChangeNotifier {
  final List<Movie> _movies = [];
  final Map<int, List<Movie>> _moviesByGenre = {};
  bool _isSearching = false; // Novo booleano para controlar o estado de busca

  List<Movie> get movies => _movies;
  Map<int, List<Movie>> get moviesByGenre => _moviesByGenre;
  bool get isSearching => _isSearching;

  // Define o estado de busca
  void setSearchMode(bool searching) {
    _isSearching = searching;
    notifyListeners();
  }

  // Busca filmes pela pesquisa do usuário
  Future<void> fetchMovies(String query) async {
    const apiKey = '8b5b114df0d5caf4540f4d29744d8b73';
    final url =
        'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List results = data['results'];

        _movies.clear();
        _movies.addAll(results.map((movieData) => Movie.fromJson(movieData)));
        _isSearching = true; // Ativa o modo de busca
        notifyListeners();
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (error) {
      print('Erro ao buscar filmes: $error');
    }
  }

  // Busca filmes por gênero
  Future<void> fetchMoviesByGenre(int genreId) async {
    const apiKey = '8b5b114df0d5caf4540f4d29744d8b73';
    final url =
        'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&with_genres=$genreId';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List results = data['results'];

        _moviesByGenre[genreId] = results
            .map((movieData) => Movie.fromJson(movieData))
            .toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load movies by genre');
      }
    } catch (error) {
      print('Erro ao buscar filmes por gênero: $error');
    }
  }

  // Reseta o modo de busca e limpa a lista de pesquisa
  void resetSearch() {
    _movies.clear();
    _isSearching = false;
    notifyListeners();
  }
}
