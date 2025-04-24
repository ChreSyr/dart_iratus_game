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

  test('From standart start, all castlings are enabled.', () {
    expect(game.board.startFEN.castleRights == 'QKqk', true);
  });

  test('Short castle works.', () {
    game.move('d4');
    game.move('g6');
    game.move('Bf4');
    game.move('Nf6');
    game.move('Nc3');
    game.move('Bg7');
    game.move('Qd2');

    expect(game.board.validNotations.contains('0-0'), true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'e8')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'e8'))!.id ==
            Role.king,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'f8')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'g8')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'h8')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'h8'))!.id ==
            Role.rook,
        true);

    game.move('0-0');

    expect(game.board.lastMove!.notation == '0-0', true);
    expect(
        game.board.getFEN().fenEqualizer ==
            'fd(0)s(0)yys(1)d(1)g/rnbq1rk1/ppppppbp/5np1/8/3P1B2/2N5/PPPQPPPP/R3KBNR/FD(2)S(2)YYS(3)D(3)G w QK -',
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'e8')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'f8')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'f8'))!.id ==
            Role.rook,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'g8')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'g8'))!.id ==
            Role.king,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'h8')) == null,
        true);
  });

  test('Undoing short castle works.', () {
    game.undo();

    expect(game.board.validNotations.contains('0-0'), true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'e8')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'e8'))!.id ==
            Role.king,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'f8')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'g8')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'h8')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'h8'))!.id ==
            Role.rook,
        true);
  });

  test('Redoing short castle works.', () {
    game.redo();

    expect(game.board.lastMove!.notation == '0-0', true);
    expect(
        game.board.getFEN().fenEqualizer ==
            'fd(0)s(0)yys(1)d(1)g/rnbq1rk1/ppppppbp/5np1/8/3P1B2/2N5/PPPQPPPP/R3KBNR/FD(2)S(2)YYS(3)D(3)G w QK -',
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'e8')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'f8')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'f8'))!.id ==
            Role.rook,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'g8')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'g8'))!.id ==
            Role.king,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'h8')) == null,
        true);
  });

  test('Long castle works.', () {
    expect(game.board.validNotations.contains('0-0-0'), true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'a1')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'a1'))!.id ==
            Role.rook,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'b1')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'c1')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd1')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'e1')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'e1'))!.id ==
            Role.king,
        true);

    game.move('0-0-0');

    expect(game.board.lastMove!.notation == '0-0-0', true);
    expect(
        game.board.getFEN().fenEqualizer ==
            'fd(0)s(0)yys(1)d(1)g/rnbq1rk1/ppppppbp/5np1/8/3P1B2/2N5/PPPQPPPP/2KR1BNR/FD(2)S(2)YYS(3)D(3)G b - -',
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'a1')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'b1')) == null,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'c1'))!.id ==
            Role.king,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'c1')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'd1'))!.id ==
            Role.rook,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd1')) is Piece,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'e1')) == null,
        true);
  });

  test('Undoing Long castle works.', () {
    game.undo();

    expect(game.board.validNotations.contains('0-0-0'), true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'a1')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'a1'))!.id ==
            Role.rook,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'b1')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'c1')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd1')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'e1')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'e1'))!.id ==
            Role.king,
        true);
  });

  test('Redoing Long castle works.', () {
    game.redo();

    expect(game.board.lastMove!.notation == '0-0-0', true);
    expect(
        game.board.getFEN().fenEqualizer ==
            'fd(0)s(0)yys(1)d(1)g/rnbq1rk1/ppppppbp/5np1/8/3P1B2/2N5/PPPQPPPP/2KR1BNR/FD(2)S(2)YYS(3)D(3)G b - -',
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'a1')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'b1')) == null,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'c1'))!.id ==
            Role.king,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'c1')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'd1'))!.id ==
            Role.rook,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd1')) is Piece,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'e1')) == null,
        true);
  });

  test('Castlings can be enabled by FEN.', () {
    // In this starting fen, there is a king, two rooks and a queen for each side.
    game = IratusGame.fromFEN('8/r3k2r/8/8/8/8/8/8/R3K2R/8 w QKqk - - 3 46');

    expect(game.board.validNotations.contains('0-0'), true);
    expect(game.board.validNotations.contains('0-0-0'), true);
    // g1 & g8 are short castles, c1 & c8 are long castles
    expect(
        legalMovesToString(game.board.king[Side.white]!) ==
            'f1, d1, f2, e2, d2, f0, e0, d0, c1, g1',
        true);

    game.move('Kd0');

    expect(
        legalMovesToString(game.board.king[Side.black]!) ==
            'f8, d8, f9, e9, d9, f7, e7, d7, c8, g8',
        true);
  });

  test('Castlings can be disabled by FEN.', () {
    // In this starting fen, there is a king, two rooks and a queen for each side.
    game = IratusGame.fromFEN('8/r3k2r/8/8/8/8/8/8/R3K2R/8 w - - - 3 46');

    expect(!game.board.validNotations.contains('0-0'), true);
    expect(!game.board.validNotations.contains('0-0-0'), true);
    // g1 & g8 are short castles, c1 & c8 are long castles
    expect(
        legalMovesToString(game.board.king[Side.white]!) ==
            'f1, d1, f2, e2, d2, f0, e0, d0',
        true);

    game.move('Ke0');

    expect(
        legalMovesToString(game.board.king[Side.black]!) ==
            'f8, d8, f9, e9, d9, f7, e7, d7',
        true);
  });

  test('Can\'t castle through a checked square.', () {
    // In this starting fen, there is a king, two rooks and a queen for each side.
    game =
        IratusGame.fromFEN('8/r3k2r/1Q6/8/8/8/1q6/8/R3K2R/8 w QKqk - - 3 46');

    expect(game.board.validNotations.contains('0-0'), true);
    // g1 is short castle
    expect(
        legalMovesToString(game.board.king[Side.white]!) ==
            'f1, f2, e2, d2, f0, d0, g1',
        true);

    game.move('Qb6');

    expect(game.board.validNotations.contains('0-0'), true);
    // g1 is short castle
    expect(
        legalMovesToString(game.board.king[Side.black]!) ==
            'f8, f9, d9, f7, e7, d7, g8',
        true);

    game.move('Qh3');

    expect(game.board.validNotations.contains('0-0-0'), true);
    // c1 is long castle
    expect(
        legalMovesToString(game.board.king[Side.white]!) ==
            'd1, f2, e2, d2, f0, d0, c1',
        true);

    game.move('Qh6');

    expect(game.board.validNotations.contains('0-0-0'), true);
    // c8 is long castle
    expect(
        legalMovesToString(game.board.king[Side.black]!) ==
            'd8, f9, d9, f7, e7, d7, c8',
        true);
  });

  test('Can\'t castle while in check.', () {
    game.move('Qf3');
    game.move('Qe3');

    expect(game.board.lastMove!.notation == 'Qe3+', true);
    expect(
        legalMovesToString(game.board.king[Side.black]!) ==
            'f8, d8, f9, d9, f7, d7',
        true);
  });
}
