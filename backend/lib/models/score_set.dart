// a set (gig, rehearsal etc), only stores piece ids not files
// firestore: users/{uid}/sets/{setId}
class ScoreSet {
  const ScoreSet({
    required this.id,
    required this.name,
    this.pieceIds = const [],
    this.performanceDate,
  });

  final String id;
  final String name;

  // in order
  final List<String> pieceIds;
  final DateTime? performanceDate;

  ScoreSet copyWith({String? name, List<String>? pieceIds}) {
    return ScoreSet(
      id: id,
      name: name ?? this.name,
      pieceIds: pieceIds ?? this.pieceIds,
      performanceDate: performanceDate,
    );
  }

  ScoreSet addPiece(String pieceId) =>
      pieceIds.contains(pieceId) ? this : copyWith(pieceIds: [...pieceIds, pieceId]);

  ScoreSet removePiece(String pieceId) =>
      copyWith(pieceIds: pieceIds.where((id) => id != pieceId).toList());

  factory ScoreSet.fromMap(String id, Map<String, dynamic> map) {
    final date = map['performanceDate'] as String?;
    return ScoreSet(
      id: id,
      name: map['name'] as String,
      pieceIds: List<String>.from(map['pieceIds'] as List? ?? const []),
      performanceDate: date == null ? null : DateTime.parse(date),
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'pieceIds': pieceIds,
        'performanceDate': performanceDate?.toIso8601String(),
      };
}
