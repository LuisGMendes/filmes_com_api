import 'package:flutter/material.dart';
import '../model/movie.dart';
import '../screens/filmeView.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final int index;

  const MovieCard({
    super.key,
    required this.movie,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FilmeView(movie: movie),
          ),
        );
      },
      child: Card(
        color: Colors.black54,
        margin: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 150, // Define uma largura fixa
          height: 300, // Altura aumentada para evitar cortes
          child: Image.network(
            movie.posterPath,
            width: 150, // Ajusta a largura da imagem ao card
            height: 400, // Altura ajustada
            fit: BoxFit.cover, // Cobre o espaço proporcionalmente
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.error,
              color: Colors.red,
              size: 50,
            ), // Placeholder para erro na imagem
          ),
        ),
      ),
    );
  }
}
