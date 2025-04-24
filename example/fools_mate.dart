import 'package:dart_iratus_game/dart_iratus_game.dart';

void main() {
  IratusGame game = IratusGame();
  game.move('f3');
  game.move('e6');
  game.move('g4');
  game.move('Qh4');
  print(game.getPGN());
}
