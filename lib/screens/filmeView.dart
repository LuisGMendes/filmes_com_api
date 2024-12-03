import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/movie.dart';
import 'package:google_fonts/google_fonts.dart';

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
               icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20,)),
              backgroundColor: Colors.deepPurple,
              title: Text(
                movie.title,
                style: const TextStyle(color: Colors.white),
              ),
              centerTitle: true,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                movie.posterPath,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Lançamento: ${movie.releaseDate}',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: SizedBox(
                width: 600,
                child: Text(
                  movie.overview,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
