import 'package:dart_iratus_game/dart_iratus_game.dart';

void main() {
  IratusGame game = IratusGame();
  while (game.result == 0) {
    var moves = game.board.validNotations.toList();
    moves.shuffle();
    var move = moves[0];
    game.move(move);
    print('Played: $move');
  }
  ConsoleView.printBoard(game.board);
  print(game.getPGN());
}
