// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
// Importa las otras pantallas que necesites

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guía Interactiva de Manizales',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Roboto',
      ),
      // Opción 1: Usar 'home' en lugar de routes si solo necesitas una pantalla inicial
      home: const HomeScreen(),
      
      // Opción 2: Si necesitas rutas con navegación, quita el 'const'
      /*
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(), // SIN 'const'
        '/lugares_favoritos': (context) => LugaresFavoritosScreen(),
        '/mapa': (context) => MapScreen(),
      },
      */
    );
  }
}