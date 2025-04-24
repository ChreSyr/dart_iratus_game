import 'package:dart_iratus_game/dart_iratus_game.dart';
import 'package:test/test.dart';

void main() {
  String legalMovesToString(Piece piece) {
    return piece.board.allLegalMoves
        .where((m) => m.piece == piece)
        .map((m) => m.end.coord)
        .join(', ');
  }

  Iterable<Move> legalMoves(Piece piece) {
    return piece.board.allLegalMoves.where((m) => m.piece == piece);
  }

  IratusGame game = IratusGame();

  test('From standart start, a dynamite can attach itself 16 pieces.', () {
    for (Piece piece in game.board.pieces) {
      if (piece.id == Role.dynamite) {
        expect(piece.identity.getValidMoves().length == 16, true);
      }
    }
  });

  test('From standart start, knights and bishops can equip the dynamite.', () {
    expect(game.board.validNotations.contains('N+d0'), true);
    expect(game.board.validNotations.contains('B+d0'), true);
    expect(game.board.validNotations.contains('B+e0'), true);
    expect(game.board.validNotations.contains('N+e0'), true);
  });

  test('A dynamite cannot attach itself to a piece who has already moved.', () {
    game.move('e4');
    game.move('e5');

    for (Piece piece in game.board.piecesColored[Side.white]!) {
      if (piece.id == Role.dynamite) {
        expect(piece.identity.getValidMoves().length == 15, true);
      }
    }
  });

  test('Capturing a dynamited piece blows the capturer.', () {
    game.move('Yd+d2');
    game.move('d6');
    game.move('d4');
    game.move('exd4*');

    expect(game.board.getPiece(Position.fromCoords(game.board, 'd4')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'e5')) == null,
        true);
  });

  test('Undoing a dynamite blow works.', () {
    game.undo();

    expect(game.board.getPiece(Position.fromCoords(game.board, 'd4')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'd4'))!.id ==
            Role.pawn,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'e5')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'e5'))!.id ==
            Role.pawn,
        true);
  });

  test('Redoing a dynamite blow works.', () {
    game.redo();

    expect(game.board.getPiece(Position.fromCoords(game.board, 'd4')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'e5')) == null,
        true);
  });

  test('A king can\'t capture a dynamited piece.', () {
    game.move('Y+g1');
    game.move('Ke7');
    game.move('Nf3');
    game.move('Ke6');
    game.move('Ne5');

    expect(legalMoves(game.board.king[Side.black]!).length == 2, true);
    expect(
        legalMoves(game.board.king[Side.black]!)
            .every((element) => element.end.coord != 'e5'),
        true);
    expect(legalMovesToString(game.board.king[Side.black]!) == 'f6, e7', true);
  });

  test('A dynamited piece can\'t be captured if it creates a discovered check.',
      () {
    game.move('d5');
    game.move('Qe2');
    game.move('dxe4');
    game.move('Qxe4');
    game.move('f6');
    game.move('Be2');

    Piece pawnF6 = game.board.getPiece(Position.fromCoords(game.board, 'f6'))!;
    expect(legalMoves(pawnF6).length == 2, true);
    expect(
        legalMoves(pawnF6).every((element) => element.end.coord != 'e5'), true);
    expect(legalMovesToString(pawnF6) == 'f5, f4', true);
  });
}
