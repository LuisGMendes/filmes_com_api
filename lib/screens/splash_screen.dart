import 'package:flutter/material.dart';
import 'home_screen.dart'; // Importe o arquivo da tela principal

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
              size: 100,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            const Text(
              'Catálogo de Filmes',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Navegar para a tela principal
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(title: 'Filmes com API'),
                  ),
                );
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

