import 'package:dart_iratus_game/dart_iratus_game.dart';

void main() {
  IratusGame game = IratusGame.fromFEN(
      'b~d(0)s(0)yys(1)d(1)g/rn1qk1nr/p1pp1p1p/1p2p1p1/4b3/1P4P1/P1N2N1P/C1PPPP2/R1BQKBCR/S~2YY2G b QKqk - 1111110000000-0000000000001111 0 10');
  print(game.getPGN());
  ConsoleView.printBoard(game.board);
}
