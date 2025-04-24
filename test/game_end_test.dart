import 'package:dart_iratus_game/dart_iratus_game.dart';
import 'package:test/test.dart';

void main() {
  test('Checkmate.', () {
    IratusGame game = IratusGame();
    game.move('f3');
    game.move('e6');
    game.move('g4');
    game.move('Qh4');

    expect(game.result == 1, true);
    expect(game.winner == 3, true);
  });

  test('Resignation.', () {
    IratusGame game = IratusGame();
    game.resign(Side.white);
    expect(game.result == 2, true);
    expect(game.winner == 3, true);

    IratusGame game2 = IratusGame();
    game2.resign(Side.black);
    expect(game.result == 2, true);
    expect(game2.winner == 2, true);
  });

  test('Stalemate.', () {
    IratusGame game =
        IratusGame.fromFEN('K/1r8/8/k8/8/8/8/8/8/8 b - - - 1 150');
    game.move('Ka7');

    expect(game.result == 4, true);
    expect(game.winner == 1, true);
  });

  test('Draw by three time repetition.', () {
    IratusGame game = IratusGame();
    game.move('Nc3');
    game.move('Nc6');
    game.move('Nf3');
    game.move('Nf6');
    game.move('Ng1');
    game.move('Ng8');
    game.move('Nf3');
    game.move('Nf6');
    game.move('Ng1');
    game.move('Ng8');

    expect(game.result == 6, true);
    expect(game.winner == 1, true);
  });

  test('Draw by insufficient material.', () {
    IratusGame game =
        IratusGame.fromFEN('K/1q~8/8/8/8/8/k8/8/8/8 w - - - 1 150');
    game.move('Kxb8');

    expect(game.result == 7, true);
    expect(game.winner == 1, true);
  });

  test('Draw by 50 moves rule.', () {
    IratusGame game = IratusGame.fromFEN(
        'f7/rnbqkbnr/8/8/8/8/8/8/RNBQKBNR/F7 w QKqk - 0000-0000 99 1');
    game.move('Nc3');
    game.move('Nc6');

    expect(game.result == 8, true);
    expect(game.winner == 1, true);
  });
}
