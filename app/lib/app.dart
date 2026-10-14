import 'package:flutter/material.dart';

import 'screens/library_screen.dart';

class SheetMusicVaultApp extends StatelessWidget {
  const SheetMusicVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sheet Music Vault',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF3B4A6B),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: const Color(0xFF3B4A6B),
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const LibraryScreen(),
    );
  }
}
