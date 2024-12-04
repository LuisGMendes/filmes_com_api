import 'package:filmes_com_api/component/movie_card.dart';
import 'package:filmes_com_api/model/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../model/movie.dart';

class FilmeView extends StatelessWidget {
  final Movie movie;

  const FilmeView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
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
              leading: IconButton(onPressed: (){
                Navigator.pop(context);
              },
               icon: const Icon(Icons.arrow_back, color: Colors.white, size: 32,)),
              backgroundColor: Colors.deepPurple,
              titleTextStyle: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ), 
              title: Text(
                movie.title,
                maxLines: 1,
                overflow: TextOverflow.fade,
              ),
              centerTitle: true,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16), // Bordas arredondadas para a sombra
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.withOpacity(0.6),
                          blurRadius: 40, // Intensidade do desfoque da sombra
                          spreadRadius: 268, // Alcance da sombra
                          offset: const Offset(0, 4), // Posicionamento da sombra
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 476,
                    width: 356,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16), // Bordas arredondadas para a sombra
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.6),
                          blurRadius: 40, // Intensidade do desfoque da sombra
                          spreadRadius: 10, // Alcance da sombra
                          offset: const Offset(0, 20), // Posicionamento da sombra
                        ),
                      ],
                    ),
                  ),
                  // Imagem
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      movie.posterPath,
                      height: 476,
                      width: 356,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.deepPurple,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Lançamento: ${movie.releaseDate}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        'Popularidade:',
                        style: GoogleFonts.poppins(
                          color: Colors.deepPurple,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        bool isFilled = movie.popularity >= (index + 1) * 200;
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            const Icon(
                              Icons.star_border,
                              color: Colors.black,
                              size: 48,
                            ),
                            Icon(
                              isFilled ? Icons.star : Icons.star_border,
                              color: Colors.yellow,
                              size: 32,
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: IntrinsicHeight(
                child: Container(
                  width: 600,
                  height: MediaQuery.of(context).size.height * .4,
                  margin: const EdgeInsets.only(left: 16.0, right: 16.0,),
                  decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.deepPurple,
                    width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.grey[700],
                    ),
                  child: Text(
                    movie.overview,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox( height: 16,),
            Consumer<MovieProvider>(
  builder: (context, provider, child) {
    // List para armazenar filmes de todos os gêneros
    final genreIds = movie.genreIds;
    if (genreIds.isEmpty) {
      return Text(
        'Nenhum gênero associado.',
        style: GoogleFonts.poppins(color: Colors.white),
      );
    }

    // Buscar filmes para cada gênero associado ao filme selecionado
    for (var genreId in genreIds) {
      if (provider.moviesByGenre[genreId] == null) {
        // Carregar os filmes se ainda não tiver sido carregado para esse gênero
        provider.fetchMoviesByGenre(genreId);
      }
    }

    // Todos os filmes que vão ser exibidos, combinando filmes de diferentes gêneros
    List<Movie> allMovies = [];
    for (var genreId in genreIds) {
      final movies = provider.moviesByGenre[genreId];
      if (movies != null) {
        allMovies.addAll(movies);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Sugestões',
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 300, // Define a altura da lista horizontal
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: allMovies.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: MovieCard(
                  movie: allMovies[index],
                  index: index,
                ),
              );
            },
          ),
        ),
      ],
    );
  },
),
          ],
        ),
      ),
    );
  }
}
