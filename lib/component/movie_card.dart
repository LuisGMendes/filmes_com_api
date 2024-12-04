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
        elevation: 80, // Dá a aparência de flutuação
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0), // Bordas arredondadas do card
        ),
        shadowColor: Colors.deepPurpleAccent.withOpacity(0.9),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
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
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child; // Imagem carregada, retorna o widget filho
                }

                // Delay para garantir que o loading seja exibido por pelo menos 1 segundo
                return FutureBuilder(
                  future: Future.delayed(const Duration(seconds: 1)), // Aguarda 1 segundo
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return child; // Exibe a imagem após o delay
                    }

                    // Durante o delay, exibe o CircularProgressIndicator
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
