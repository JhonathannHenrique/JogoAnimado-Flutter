import 'package:flutter/material.dart';
import 'screens/garage_screen.dart';

void main() {
  runApp(const TurboRaceApp());
}

// ============================================================================
// 2. REQUISITOS DE MATERIAL DESIGN 3
// ============================================================================
class TurboRaceApp extends StatelessWidget {
  const TurboRaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo de Carros',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Ativando Material 3 explicitly e ColorScheme from blueAccent.
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.dark, // Tema de corrida fica melhor no modo escuro
        ),
      ),
      // 1. O app deve ter duas telas
      home: const GarageScreen(),
    );
  }
}
