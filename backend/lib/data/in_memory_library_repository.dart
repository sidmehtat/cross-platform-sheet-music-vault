import 'dart:async';

import '../models/piece.dart';
import '../models/score_set.dart';
import 'library_repository.dart';

// fake backend so i can build the ui without firebase
class InMemoryLibraryRepository implements LibraryRepository {
  final _pieces = <String, Piece>{};
  final _sets = <String, ScoreSet>{};
  final _piecesCtrl = StreamController<List<Piece>>.broadcast();
  final _setsCtrl = StreamController<List<ScoreSet>>.broadcast();
  int _nextId = 0;

  String _id() => (_nextId++).toString();

  @override
  Stream<List<Piece>> watchPieces() async* {
    yield _pieces.values.toList();
    yield* _piecesCtrl.stream;
  }

  @override
  Stream<List<ScoreSet>> watchSets() async* {
    yield _sets.values.toList();
    yield* _setsCtrl.stream;
  }

  @override
  Future<Piece> addPiece({required String title, String? composer, required List<int> pdfBytes}) async {
    final id = _id();
    final piece = Piece(id: id, title: title, composer: composer, storagePath: 'local/$id.pdf');
    _pieces[id] = piece;
    _piecesCtrl.add(_pieces.values.toList());
    return piece;
  }

  @override
  Future<void> deletePiece(String pieceId) async {
    _pieces.remove(pieceId);
    // take it out of any sets too
    for (final set in _sets.values.toList()) {
      _sets[set.id] = set.removePiece(pieceId);
    }
    _piecesCtrl.add(_pieces.values.toList());
    _setsCtrl.add(_sets.values.toList());
  }

  @override
  Future<ScoreSet> createSet(String name) async {
    final set = ScoreSet(id: _id(), name: name);
    _sets[set.id] = set;
    _setsCtrl.add(_sets.values.toList());
    return set;
  }

  @override
  Future<void> saveSet(ScoreSet set) async {
    _sets[set.id] = set;
    _setsCtrl.add(_sets.values.toList());
  }

  @override
  Future<void> deleteSet(String setId) async {
    _sets.remove(setId);
    _setsCtrl.add(_sets.values.toList());
  }
}
