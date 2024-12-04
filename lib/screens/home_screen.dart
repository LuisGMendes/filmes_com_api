import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:filmes_com_api/component/movie_card.dart';
import '../model/movie_provider.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    final TextEditingController _searchController = TextEditingController();

    // Busca inicial para preencher categorias e gêneros
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (movieProvider.genres.isEmpty) {
        movieProvider.fetchGenres().then((_) {
          movieProvider.genres.keys.forEach((genreId) {
            movieProvider.fetchMoviesByGenre(genreId);
          });
        });
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFF0d0e0f),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(78),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: AppBar(
              elevation: 1,
              shadowColor: Colors.grey[700],
              leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
                icon: const Icon(Icons.arrow_back, color: Colors.white, size: 32),
              ),
              backgroundColor: Colors.deepPurple,
              titleTextStyle: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ), 
              title: Text(
                title,
              ),
              centerTitle: true,
              actions: [
                if (movieProvider.isSearching)
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      _searchController.clear();
                      movieProvider.resetSearch();
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
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
              ...movieProvider.genres.entries.map((entry) {
                final genreId = entry.key;
                final genreName = entry.value;
                final movies = movieProvider.moviesByGenre[genreId] ?? [];

                return movies.isEmpty
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 200,
                                height: 46,
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.5), // Cor da sombra
                                      blurRadius: 8, // Desfoque da sombra
                                      offset: const Offset(5, 4), // Deslocamento da sombra (x, y)
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    genreName,
                                    style: GoogleFonts.domine(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
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
