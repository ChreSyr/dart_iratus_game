import 'package:dart_iratus_game/dart_iratus_game.dart';
import 'package:test/test.dart';

void main() {
  var game = IratusGame();
  var board = game.board;

  test('Game is properly initialized', () {
    expect(board.movesHistory.isEmpty, true);
    expect(board.turn == Side.white, true);
    expect(game.result == 0, true);
    expect(game.winner == 0, true);
  });

  test('IratusBoard is properly initialized', () {
    expect(board.nbcols == 8, true);
    expect(board.nbrows == 10, true);
    expect(board.pieces.length == 48, true);
  });

  test('Colors should work as intended', () {
    expect(board.piecesColored[Side.white]![0].color == Side.white, true);
    expect(board.piecesColored[Side.black]![0].color == Side.black, true);
  });
}
