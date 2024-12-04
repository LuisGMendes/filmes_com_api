import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'movie.dart';

class MovieProvider with ChangeNotifier {
  final String apiKey = '8b5b114df0d5caf4540f4d29744d8b73'; // Substitua pela sua chave da API
  final String baseUrl = 'https://api.themoviedb.org/3';

  Map<int, String> genres = {}; // Gêneros de filmes
  Map<int, List<Movie>> moviesByGenre = {}; // Filmes organizados por gênero
  List<Movie> movies = []; // Filmes para pesquisa
  bool isSearching = false; // Controle de busca

  /// Define o modo de busca
  void setSearchMode(bool searching) {
    isSearching = searching;
    notifyListeners();
  }

  /// Busca gêneros de filmes da API
  Future<void> fetchGenres() async {
    final url = Uri.parse('$baseUrl/genre/movie/list?api_key=$apiKey&language=pt-BR');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        genres = {
          for (var genre in data['genres']) genre['id']: genre['name'],
        };
        notifyListeners();
      } else {
        throw Exception('Erro ao buscar gêneros: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao buscar gêneros: $e');
    }
  }

  /// Busca filmes por gênero
  Future<void> fetchMoviesByGenre(int genreId) async {
    final url = Uri.parse('$baseUrl/discover/movie?api_key=$apiKey&with_genres=$genreId');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        moviesByGenre[genreId] = (data['results'] as List)
            .map((movieData) => Movie.fromJson(movieData))
            .toList();
        notifyListeners();
      } else {
        throw Exception('Erro ao buscar filmes do gênero $genreId: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao buscar filmes do gênero $genreId: $e');
    }
  }

  /// Busca filmes por texto
  Future<void> fetchMovies(String query) async {
    final url = Uri.parse('$baseUrl/search/movie?api_key=$apiKey&query=$query');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        movies = (data['results'] as List)
            .map((movieData) => Movie.fromJson(movieData))
            .toList();
        isSearching = true;
        notifyListeners();
      } else {
        throw Exception('Erro ao buscar filmes: ${response.statusCode}');
      }
    } catch (error) {
      print('Erro ao buscar filmes: $error');
    }
  }

  /// Reseta a pesquisa
  void resetSearch() {
    movies.clear();
    isSearching = false;
    notifyListeners();
  }
}
