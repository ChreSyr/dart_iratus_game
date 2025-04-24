import 'package:dart_iratus_game/dart_iratus_game.dart';
import 'package:test/test.dart';

void main() {
  // In this starting fen, there is two kings and a white pawn.
  // White to move and promote.
  String fen = '8/8/3P4/8/8/2K2k2/8/8/8/8 w - - 1- 0 1';

  IratusGame game = IratusGame.fromFEN(fen);
  Side oldTurn = game.board.turn;

  test('After d9, the game is waiting for the promotion input.', () {
    expect(game.board.waitingForInput, false);
    expect(
        game.board.validNotations.join(', ') ==
            'd8, d9, Kd4, Kb4, Kd5, Kc5, Kb5, Kd3, Kc3, Kb3',
        true);

    game.move('d9');

    expect(game.board.lastMove!.notation == 'd9', true);
    expect(game.board.waitingForInput, true);
    expect(oldTurn == game.board.turn, true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd7')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd9')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'd9'))!.id ==
            Role.pawn,
        true);
    expect(
        game.board.validNotations.join(', ') == '=Q, =N, =B, =R, =C, =E', true);
  });

  test('Undoing a pawn move before its promotion.', () {
    game.undo();

    expect(game.board.waitingForInput, false);
    expect(oldTurn == game.board.turn, true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd7')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'd7'))!.id ==
            Role.pawn,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd9')) == null,
        true);
    expect(
        game.board.validNotations.join(', ') ==
            'd8, d9, Kd4, Kb4, Kd5, Kc5, Kb5, Kd3, Kc3, Kb3',
        true);
  });

  test(
      'After redoing the undone move, the game is waiting for the promotion input.',
      () {
    expect(
        game.board.validNotations.join(', ') ==
            'd8, d9, Kd4, Kb4, Kd5, Kc5, Kb5, Kd3, Kc3, Kb3',
        true);

    game.redo();

    expect(game.board.lastMove!.notation == 'd9', true);
    expect(game.board.waitingForInput, true);
    expect(oldTurn == game.board.turn, true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd7')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd9')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'd9'))!.id ==
            Role.pawn,
        true);
    expect(
        game.board.validNotations.join(', ') == '=Q, =N, =B, =R, =C, =E', true);
  });

  test('Promoting to a queen.', () {
    expect(game.board.waitingForInput, true);

    game.move('=Q');

    expect(game.board.lastMove!.notation == 'd9=Q', true);
    expect(game.board.waitingForInput, false);
    expect(oldTurn != game.board.turn, true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd7')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd9')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'd9'))!.id ==
            Role.queen,
        true);
  });

  test('An undone promotion moves the pawn.', () {
    game.undo();

    expect(game.board.waitingForInput, false);
    expect(oldTurn == game.board.turn, true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd7')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'd7'))!.id ==
            Role.pawn,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd9')) == null,
        true);
  });

  test('A redone promotion doesn\'t wait for promotion input.', () {
    game.redo();

    expect(game.board.lastMove!.notation == 'd9=Q', true);
    expect(game.board.waitingForInput, false);
    expect(oldTurn != game.board.turn, true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd7')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd9')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'd9'))!.id ==
            Role.queen,
        true);
  });

  test('A promotion with discovered check is correctly noted.', () {
    // In this starting fen, there is two kings, a white rook and a white pawn.
    // White to move, promote and make a discovered check.
    fen = '8/8/1R1P2k1/8/8/2K5/8/8/8/8 w - - 1- 0 1';
    game = IratusGame.fromFEN(fen);

    game.move('d9');
    game.move('=N');

    expect(game.board.lastMove!.notation == 'd9=N+', true);
  });
}
