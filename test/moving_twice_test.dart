import 'package:dart_iratus_game/dart_iratus_game.dart';
import 'package:test/test.dart';

void main() {
  // In this starting fen, there is two kings and a white enraged dog.
  // White to move twice.
  String fen = '8/8/3C4/8/8/2K2k2/8/8/8/8 w - - 1- 0 1';

  IratusGame game = IratusGame.fromFEN(fen);
  Side oldTurn = game.board.turn;

  test(
      'After a piece moving twice has moved, it is the only piece who still has valid moves.',
      () {
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd7')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'd7'))!.id ==
            Role.enragedDog,
        true);
    expect(
        game.board.validNotations.join(', ') ==
            'Ce7, Cc7, Cd6, Cd8, Kd4, Kb4, Kd5, Kc5, Kb5, Kd3, Kc3, Kb3',
        true);

    game.move('Cd6');

    expect(game.board.lastMove!.waitingForInput, true);
    expect(game.board.lastMove!.notation == 'Cd6', true);
    expect(game.getPGN().moveText == '1. Cd6', true);
    expect(oldTurn == game.board.turn, true);
    expect(game.board.validNotations.join(', ') == 'Ce6, Cc6, Cd5, Cd7', true);
  });

  test('After a piece moving twice has moved twice, the enemies can move.', () {
    game.move('Ce6');

    expect(game.board.lastMove!.waitingForInput, false);
    expect(game.board.lastMove!.notation == 'Cd6-Ce6', true);
    expect(game.getPGN().moveText == '1. Cd6-Ce6', true);
    expect(oldTurn != game.board.turn, true);
    expect(game.board.validNotations.join(', ') == 'Kg4, Kg5, Kg3, Kf3, Ke3',
        true);
  });

  test('After undoing a double move, both moves are undone.', () {
    game.undo();

    expect(oldTurn == game.board.turn, true);
    expect(
        game.board.validNotations.join(', ') ==
            'Ce7, Cc7, Cd6, Cd8, Kd4, Kb4, Kd5, Kc5, Kb5, Kd3, Kc3, Kb3',
        true);
  });

  test('After redoing a double move, both moves are redone.', () {
    game.redo();

    expect(oldTurn != game.board.turn, true);
  });

  test('A double move with check is correctly noted.', () {
    game.move('Kg4');
    game.move('Ce5');
    game.move('Ce4');

    expect(game.board.lastMove!.notation == 'Ce5-Ce4+', true);
    expect(game.getPGN().moveText == '1. Cd6-Ce6 Kg4 2. Ce5-Ce4+', true);
  });

  test('A check from a piece moving twice works.', () {
    fen = '8/8/8/3C_4/5c2/2K2k2/8/8/P7/8 b - - 0- 2 1';
    game = IratusGame.fromFEN(fen);
    oldTurn = game.board.turn;

    game.move('Ce5');
    game.move('Ce4');

    expect(game.board.lastMove!.notation == 'Ce5-Ce4+', true);
    expect(game.getPGN().moveText == '1. ... Ce5-Ce4+', true);
    expect(
        game.board.validNotations.join(', ') == 'Cd5, Kb4, Kc5, Kb5, Kc3, Kb3',
        true);
  });

  test(
      'A check from a piece moving twice can be intercepted by a dynamited piece.',
      () {
    game.move('Cd5');

    expect(game.board.lastMove!.notation == 'Cd5', true);
    expect(game.board.validNotations.join(', ') == 'Cd4', true);

    game.move('Cd4');

    expect(game.board.lastMove!.notation == 'Cd5-Cd4+', true);
    expect(
        game.board.validNotations.join(', ') ==
            'Cxd4*, Kg4, Kg5, Kf5, Kg3, Kf3',
        true);
  });

  test(
      'If a piece moving twice is blown up by dynamite, the turn goes to the enemies.',
      () {
    game.move('Cxd4*');

    expect(game.board.lastMove!.notation == 'Cxd4*', true);
    expect(game.getPGN().moveText == '1. ... Ce5-Ce4+ 2. Cd5-Cd4+ Cxd4*', true);
    expect(oldTurn != game.board.turn, true);
    expect(
        game.board.validNotations.join(', ') ==
            'Kd4, Kb4, Kd5, Kc5, Kb5, Kd3, Kc3, Kb3, a2, a3',
        true);
  });
}
