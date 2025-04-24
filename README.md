# iratus_game

iratus_game is a package designed to play the Iratus chess variant.

It includes all the features necessary for classic chess such as FEN and PGN notations.

## Getting started

Easily start a game in the console :

```dart
import 'package:dart_iratus_game/dart_iratus_game.dart';

void main() {
  ConsoleView cv = ConsoleView();
  cv.start();
}
```

Or create a randomized game :

```dart
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
```

## Additional information

- [Iratus Official Website](https://iratus.fr)
- [iratus_game on pub.dev](https://pub.dev/packages/iratus_game)
- [Wikipedia's Article on FEN Format](http://en.wikipedia.org/wiki/Forsyth–Edwards_Notation)
- [Wikipedia's Article on PGN Format](http://en.wikipedia.org/wiki/Portable_Game_Notation)
