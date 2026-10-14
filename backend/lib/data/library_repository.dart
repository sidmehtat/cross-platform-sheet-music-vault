import '../models/piece.dart';
import '../models/score_set.dart';

// what the app uses to get data. firebase version coming later,
// using the in memory one for now
abstract class LibraryRepository {
  Stream<List<Piece>> watchPieces();
  Stream<List<ScoreSet>> watchSets();

  // uploads the pdf once and makes the piece
  Future<Piece> addPiece({required String title, String? composer, required List<int> pdfBytes});
  Future<void> deletePiece(String pieceId);

  Future<ScoreSet> createSet(String name);
  Future<void> saveSet(ScoreSet set);
  Future<void> deleteSet(String setId);
}
