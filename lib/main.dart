import 'package:filmes_com_api/screens/home_screen.dart';
import 'package:flutter/material.dart';
import './model/movieProvider.dart';
import 'package:provider/provider.dart';
import 'package:filmes_com_api/screens/splash_screen.dart'; // Importa a SplashScreen

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Filmes', // Novo título
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), // Cor principal
        useMaterial3: true,
      ),
      home: const SplashScreen(), // Define a SplashScreen como tela inicial
    );
  }
}
