import '../models/piece.dart';
import '../models/score_set.dart';

/// Everything the UI needs from the backend. The Firebase version
/// comes later; for now [InMemoryLibraryRepository] lets me build screens.
abstract class LibraryRepository {
  Stream<List<Piece>> watchPieces();
  Stream<List<ScoreSet>> watchSets();

  /// Uploads the PDF once and creates the piece record.
  Future<Piece> addPiece({required String title, String? composer, required List<int> pdfBytes});
  Future<void> deletePiece(String pieceId);

  Future<ScoreSet> createSet(String name);
  Future<void> saveSet(ScoreSet set);
  Future<void> deleteSet(String setId);
}
