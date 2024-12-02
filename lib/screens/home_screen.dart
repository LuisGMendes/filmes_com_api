import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:filmes_com_api/component/movie_card.dart';
import '../model/movie_provider.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    // IDs dos gêneros e seus respectivos nomes
    final genres = {
      28: 'Ação',
      35: 'Comédia',
      18: 'Drama',
      27: 'Terror',
      10749: 'Romance',
    };

    // Busca inicial para preencher categorias
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!movieProvider.isSearching) {
        genres.keys.forEach((genreId) {
          movieProvider.fetchMoviesByGenre(genreId);
        });
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFF0d0e0f),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          if (movieProvider.isSearching)
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () {
                movieProvider.resetSearch(); // Reseta o estado de busca
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    movieProvider.fetchMovies(value);
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Buscar filme...',
                  hintStyle: const TextStyle(color: Colors.white54),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  filled: true,
                  fillColor: const Color(0xFF1C1C1E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            if (movieProvider.isSearching)
              // Mostra resultados da pesquisa
              movieProvider.movies.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhum filme encontrado.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: movieProvider.movies.length,
                          itemBuilder: (context, index) {
                            final movie = movieProvider.movies[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: MovieCard(movie: movie, index: index),
                            );
                          },
                        ),
                      ),
                    )
            else
              // Mostra categorias se não estiver no modo de busca
              ...genres.entries.map((entry) {
                final genreId = entry.key;
                final genreName = entry.value;
                final movies = movieProvider.moviesByGenre[genreId] ?? [];

                return movies.isEmpty
                    ? const SizedBox() // Evita mostrar se a lista estiver vazia
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              genreName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: movies.length,
                                itemBuilder: (context, index) {
                                  final movie = movies[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    child: MovieCard(movie: movie, index: index),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
              }).toList(),
          ],
        ),
      ),
    );
  }
}
