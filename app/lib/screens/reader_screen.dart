import 'package:flutter/material.dart';

/// Swipe-to-turn reader. Placeholder pages for now - real PDF
/// rendering lands once the renderer is picked (story R-1).
class ReaderScreen extends StatefulWidget {
  const ReaderScreen({super.key, required this.title, this.pageCount = 5});

  final String title;
  final int pageCount;

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  final _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: PageView.builder(
        controller: _controller,
        itemCount: widget.pageCount,
        onPageChanged: (i) => setState(() => _page = i),
        itemBuilder: (_, i) => Padding(
          padding: const EdgeInsets.all(16),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black12),
            ),
            child: Center(
              child: Text('Page ${i + 1}', style: const TextStyle(color: Colors.black54)),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          '${_page + 1} / ${widget.pageCount}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
