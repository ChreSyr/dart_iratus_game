// Phantoms are correctly transformed
// It is possible to have 0, 1 or more phantoms

import 'package:dart_iratus_game/dart_iratus_game.dart';
import 'package:test/test.dart';

void main() {
  String legalMovesToString(Piece piece) {
    return piece.board.allLegalMoves
        .where((m) => m.piece == piece)
        .map((m) => m.end.coord)
        .join(', ');
  }

  IratusGame game = IratusGame();
  Board board = game.board;
  Piece wPhantom = board.getPiece(Position.fromCoords(board, 'a0'))!;
  Piece bPhantom = board.getPiece(Position.fromCoords(board, 'a9'))!;

  test('Phantomization works.', () {
    game.move('a4');
    game.move('b5');
    game.move('axb5');

    expect(wPhantom.id == Role.phantom, true);
    expect(bPhantom.id == Role.pawn, true);
  });

  test('Phantomization can be undone.', () {
    game.undo();

    expect(bPhantom.id == Role.phantom, true);
  });

  test('Phantomization can be redone.', () {
    game.redo();

    expect(bPhantom.id == Role.pawn, true);
  });

  test('Multiple phantomization works.', () {
    game.move('a6');
    game.move('bxa6');
    game.move('Rxa6');
    game.move('Rxa6');

    expect(wPhantom.id == Role.pawn, true);
    expect(bPhantom.id == Role.rook, true);
    expect(legalMovesToString(bPhantom) == 'a8, a7, a6', true);
  });

  test('A phantom move is noted with the id of the piece followed by \'~\'.',
      () {
    game.move('R~xa6');

    expect(board.lastMove!.notation == 'R~xa6', true);
  });

  test(
      'A phantom\'s check can be avoided by capture, turning it into another piece.',
      () {
    game.move('R~xa6');
    game.move('f5');
    game.move('R~f6');
    game.move('f3');
    game.move('e4');
    game.move('Nc6');
    game.move('Qxf3');
    game.move('Nd4');
    game.move('R~xf8');

    expect(board.lastMove!.notation == 'R~xf8+', true);
    expect(game.board.validNotations.join(', ') == 'Nxc2', true);
  });

  test('A phantom can checkmate.', () {
    game.undo();
    game.undo();
    game.move('Ne5');
    game.move('R~xf8');

    expect(board.lastMove!.notation == 'R~xf8#', true);
  });

  test('A piece protected by the phantom can checkmate.', () {
    game = IratusGame();
    game.move('a4');
    game.move('b5');
    game.move('axb5');
    game.move('a6');
    game.move('bxa6');
    game.move('Rxa6');
    game.move('Rxa6');
    game.move('R~xa6');
    game.move('R~xa6');
    game.move('f5');
    game.move('R~f6');
    game.move('f3');
    game.move('e4');
    game.move('Nc6');
    game.move('Qxf3');
    game.move('Nb4');
    game.move('Qb3');
    game.move('Nc6');
    game.move('Qf7');

    expect(game.board.lastMove!.notation == 'Qf7#', true);
  });

  test(
      'A king can avoid a phantom`s check by capturing a piece, even if it was protected by the phantom.',
      () {
    // In this starting fen, the king can eat the pawn but not go forward.
    game = IratusGame.fromFEN(
        'k7/3r~4/2S(0)1S(1)3/2D(0)KD(1)3/2PpP3/8/8/8/8/8 w - - 000000-0 0 10');

    expect(legalMovesToString(game.board.king[Side.white]!) == 'd5', true);
    expect(game.board.validNotations.join(', ') == 'Kxd5', true);
  });

  test('The promotion of a pawn\'s phantom works.', () {
    // In this starting fen, the white pawn can take a pawn or a soldier. The black phantom will then promote.
    game =
        IratusGame.fromFEN('8/8/8/2p1s3/3P4/8/8/8/1K2f1k1/8 w - - 0-00 0 10');

    bPhantom = game.board.getPiece(Position.fromCoords(game.board, 'e1'))!;

    game.move('dxc6');
    game.move('P~e0');
    game.move('=Q');

    expect(game.board.lastMove!.notation == 'P~e0=Q', true);
    expect(bPhantom.id == Role.queen, true);
  });

  test('The promotion of a soldier\'s phantom works.', () {
    game.undo();
    game.undo();
    game.move('dxe6');
    game.move('S~d0=E');

    expect(game.board.lastMove!.notation == 'S~d0=E', true);
    expect(bPhantom.id == Role.eliteSoldier, true);
  });
}
