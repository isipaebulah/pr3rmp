import 'package:flutter/material.dart';
import 'services/api_client.dart';
import 'screens/trivia_screen.dart';

void main() {
  // Инициализируем get_it перед запуском приложения
  setupDependencies(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const TriviaScreen(), // Убрали ошибку с const
    );
  }
}