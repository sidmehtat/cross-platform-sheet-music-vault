// one piece = one pdf
// firestore: users/{uid}/pieces/{pieceId}
// storage: users/{uid}/scores/{pieceId}.pdf
class Piece {
  const Piece({
    required this.id,
    required this.title,
    required this.storagePath,
    this.composer,
    this.pageCount = 0,
    this.tags = const [],
  });

  final String id;
  final String title;
  final String? composer;

  final String storagePath;
  final int pageCount;
  final List<String> tags;

  factory Piece.fromMap(String id, Map<String, dynamic> map) {
    return Piece(
      id: id,
      title: map['title'] as String,
      composer: map['composer'] as String?,
      storagePath: map['storagePath'] as String,
      pageCount: (map['pageCount'] as num?)?.toInt() ?? 0,
      tags: List<String>.from(map['tags'] as List? ?? const []),
    );
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'composer': composer,
        'storagePath': storagePath,
        'pageCount': pageCount,
        'tags': tags,
      };
}
