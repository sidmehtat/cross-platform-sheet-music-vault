import 'package:flutter/material.dart';

import 'reader_screen.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: hook up to LibraryRepository.watchPieces()
    return Scaffold(
      appBar: AppBar(title: const Text('Library')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.library_music_outlined, size: 64),
            const SizedBox(height: 12),
            const Text('No scores yet'),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ReaderScreen(title: 'Reader demo')),
              ),
              child: const Text('Open reader demo'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: null, // TODO: import PDF (story L-3)
        icon: const Icon(Icons.add),
        label: const Text('Add score'),
      ),
    );
  }
}
