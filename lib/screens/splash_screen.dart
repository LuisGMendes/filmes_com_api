// logo e texto finalizar
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0d0e0f), // Fundo escuro
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo ou imagem do app (opcional, pode substituir por outra imagem)
            const Icon(
              Icons.movie_creation_outlined,
              size: 230,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            RichText(
  text: TextSpan(
    style: const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    children: [
      const TextSpan(text: 'Cine'),
      TextSpan(
        text: 'F',
        style: GoogleFonts.poppins(
          color: Colors.purple,
          fontWeight: FontWeight.w900,
          fontSize: 58,
          shadows: [
            const Shadow(
              offset: Offset(2, 2),
              blurRadius: 2,
              color: Colors.white,
            ),
          ],
        ),
      ),
      const TextSpan(text: 'inder'),
    ],
  ),
  textAlign: TextAlign.center,
),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Navegar para a tela principal
                Navigator.pushReplacementNamed(context, '/home');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF53088c), // Cor do botão
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Entrar',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

