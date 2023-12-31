import 'dart:io';

import 'game.dart';
import 'models.dart';
import 'position.dart';

/// A bridge between the console input and an Iratus game.
class ConsoleView {
  final bool _gameInitializedFromConstructor;
  late final Game _game;
  late final Board _board;

  static final Map<String, String> _commandsDoc = {
    'exit': 'exit the programm',
    'fen': 'get the FEN of the position',
    'help': 'show commands',
    'ls': 'show all possible moves',
    'pgn': 'get the PGN of the game',
    'redo': 'redo the last undone move',
    'redoAll': 'redo all the undone moves',
    'undo': 'undo the last move',
    'undoAll': 'undo all the moves',
  };

  static final Map<String, String> _inputFENcommandsDoc = {
    'exit': 'exit the programm',
    'help': 'show commands',
    'standart': 'start standart game',
  };

  ConsoleView({Game? game}) : _gameInitializedFromConstructor = game != null {
    if (game != null) {
      _game = game;
      _board = game.board;
    }
  }

  /// Print a representation of the board in the console
  static void printBoard(Board board) {
    String italic(String str) {
      return '\x1B[3m$str\x1B[0m';
    }

    String underlined(String str) {
      return '\x1B[4m$str\x1B[0m';
    }

    String firstRowDelimiter = '  ┍━━━┯━━━┯━━━┯━━━┯━━━┯━━━┯━━━┯━━━┑';
    String rowDelimiter = '  ┝━━━┿━━━┿━━━┿━━━┿━━━┿━━━┿━━━┿━━━┥';
    String lastRowDelimiter =
        '  ┕━━━┷━━━┷━━━┷━━━┷━━━┷━━━┷━━━┷━━━┙\n    a   b   c   d   e   f   g   h  ';
    print(firstRowDelimiter);
    for (int row = 0; row < board.nbrows; row++) {
      String line = '${board.nbrows - 1 - row} │';
      for (int col = 0; col < board.nbcols; col++) {
        Piece? piece =
            board.getPiece(Position.fromRowCol(board, row: row, col: col));
        if (piece == null) {
          line += '   │';
        } else {
          String id;
          if (piece.color == Side.white) {
            id = piece.id.char.toUpperCase();
          } else {
            id = piece.id.char.toLowerCase();
          }
          if (piece.phantomized) {
            id = italic(id);
          }
          if (piece.dynamited) {
            id = underlined(id);
          }
          line += ' $id │';
        }
      }
      print(line);
      print(row < (board.nbrows - 1) ? rowDelimiter : lastRowDelimiter);
      line = '│';
    }
  }

  /// Print the notations of all the possible moves in the position
  static void printAllValidMoves(Board board) {
    print(board.validNotations.join(', '));
  }

  /// Starts the console dialogue with the players.
  void start() async {
    String? input;
    if (!_gameInitializedFromConstructor) {
      bool startedGame = false;
      print(
          'Enter a starting FEN or PGN file or enter RETURN for a standart game :');
      while (startedGame == false) {
        input = stdin.readLineSync();

        switch (input) {
          case null:
            print('No input detected');
            break;
          case 'exit':
            return;
          case 'help':
            print('Availible commands :');
            for (String command in _inputFENcommandsDoc.keys) {
              print('  $command: ${_inputFENcommandsDoc[command]}');
            }
            break;
          case 'standart':
          case '':
            _game = IratusGame();
            _board = _game.board;
            startedGame = true;
            break;
          default:
            try {
              if (input.startsWith('pgn')) {
                String pgnFilename = input.split(' ')[1];
                File pgnFile = File(pgnFilename);
                print(await pgnFile.readAsString());
                _game = IratusGame.fromPGN(await pgnFile.readAsString());
              } else {
                _game = IratusGame.fromFEN(input);
              }
              _board = _game.board;
              startedGame = true;
            } catch (e) {
              print(e.toString());
            }
        }
      }
    }
    while (_game.result == 0) {
      printBoard(_board);

      bool played = false;

      while (played == false) {
        print('Enter your move or command :');
        input = stdin.readLineSync();

        switch (input) {
          case null:
            print('No input detected');
            break;
          case 'exit':
            return;
          case 'fen':
            print(_game.board.getFEN());
          case 'help':
            print('Availible commands :');
            for (String command in _commandsDoc.keys) {
              print('  $command: ${_commandsDoc[command]}');
            }
            break;
          case 'ls':
            print('Availible moves :');
            printAllValidMoves(_board);
            break;
          case 'pgn':
            print(_game.getPGN());
            break;
          case 'redo':
            _game.redo();
            printBoard(_board);
            break;
          case 'redoAll':
            _game.redoAll();
            printBoard(_board);
            break;
          case 'undo':
            _game.undo();
            printBoard(_board);
            break;
          case 'undoAll':
            _game.undoAll();
            printBoard(_board);
            break;

          default:
            for (String valid in _board.validNotations) {
              if (input == valid) {
                _game.move(input);
                played = true;
                break;
              }
            }
            if (!played) {
              print('Wrong notation (type \'ls\' to see all valid moves)');
            }
        }
      }
    }
    printBoard(_board);
    print(
        '\nResult : ${resultDoc[_game.result]}\nWinner : ${winnerDoc[_game.winner]}\n\n${_game.getPGN()}');
  }
}

// [Event "Casual game"]\n[Site "iratus.fr"]\n[Date "2023.10.7"]\n[Time "15.2.27"]\n[White "Winston"]\n[Black "Bellucci"]\n[Result "*"]\n[Variant "Iratus"]\n\n1. e4 d6 2. e6 Qd7 3. exf7+ Kd8 4. fxg8 d5 5. gxf9=Q Cxf9-Cg9
