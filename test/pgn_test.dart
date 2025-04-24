import 'package:dart_iratus_game/dart_iratus_game.dart';
import 'package:dart_iratus_game/src/pgn.dart';
import 'package:test/test.dart';

void main() {
  IratusGame game = IratusGame();

  test('start PGN is correctly written.', () {
    PGN pgn = game.getPGN();

    expect(pgn.moveText == '', true);
    expect(pgn.tagPairs['Result'] == '*', true);
    expect(pgn.tagPairs['Variant'] == 'Iratus', true);
  });

  test('In progress game PGN is correctly written.', () {
    // 1
    game.move('f3');
    game.move('e5');
    // 2
    game.move('g4');

    PGN pgn = game.getPGN();

    expect(pgn.moveText == '1. f3 e5 2. g4', true);
    expect(pgn.tagPairs['Result'] == '*', true);
  });

  test('Ended game PGN is correctly written.', () {
    game.move('Qh4');

    PGN pgn = game.getPGN();

    expect(pgn.moveText == '1. f3 e5 2. g4 Qh4# 0-1', true);
    expect(pgn.tagPairs['Result'] == '0-1', true);
  });

  test('Starting from black game PGN is correctly written.', () {
    IratusGame game2 = IratusGame.fromFEN(
        'fd(0)s(0)yys(1)d(1)g/rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR/FD(2)S(2)YYS(3)D(3)G b QKqk e3 1000000000000000-0000000000000000 0 1');
    game2.move('e5');
    PGN pgn = game2.getPGN();

    expect(pgn.moveText == '1. ... e5', true);
    expect(pgn.tagPairs['Result'] == '*', true);
  });

  test('A PGN is correctly created from String.', () {
    IratusPGN pgn = IratusPGN.fromString('''[Event "Casual game"]
[Site "iratus.fr"]
[Date "2023.10.7"]
[Time "13.54.6"]
[White "Wall-e"]
[Black "Bumblebee"]
[Result "0-1"]
[Variant "Iratus"]

1. f3 e5 2. g4 Qh4# 0-1''');

    expect(pgn.tagPairs['Event'] == 'Casual game', true);
    expect(pgn.tagPairs['Site'] == 'iratus.fr', true);
    expect(pgn.tagPairs['Date'] == '2023.10.7', true);
    expect(pgn.tagPairs['Time'] == '13.54.6', true);
    expect(pgn.tagPairs['White'] == 'Wall-e', true);
    expect(pgn.tagPairs['Black'] == 'Bumblebee', true);
    expect(pgn.tagPairs['Result'] == '0-1', true);
    expect(pgn.tagPairs['Variant'] == 'Iratus', true);
    expect(pgn.moveText == '1. f3 e5 2. g4 Qh4# 0-1', true);
  });

  test('An IratusGame is correctly created from PGN without moves nor FEN.',
      () {
    String pgnString = '''[Event "Casual game"]
[Site "iratus.fr"]
[Date "2023.10.7"]
[Time "13.54.6"]
[White "Wall-e"]
[Black "Bumblebee"]
[Result "*"]
[Variant "Iratus"]

''';
    IratusPGN pgn = IratusPGN.fromString(pgnString);
    IratusGame game = IratusGame.fromPGN(pgnString);
    IratusPGN gamePgn = game.getPGN();

    expect(gamePgn.tagPairs['Black'] == pgn.tagPairs['Black'], true);
    expect(gamePgn.tagPairs['White'] == pgn.tagPairs['White'], true);
    expect(gamePgn.moveText == pgn.moveText, true);
    expect(gamePgn.tagPairs['Result'] == pgn.tagPairs['Result'], true);
  });

  test('An IratusGame is correctly created from PGN with moves but no FEN.',
      () {
    String pgnString = '''[Event "Casual game"]
[Site "iratus.fr"]
[Date "2023.10.7"]
[Time "13.54.6"]
[White "Wall-e"]
[Black "Bumblebee"]
[Result "*"]
[Variant "Iratus"]

1. e4 e5''';
    IratusPGN pgn = IratusPGN.fromString(pgnString);
    IratusGame game = IratusGame.fromPGN(pgnString);
    IratusPGN gamePgn = game.getPGN();

    expect(gamePgn.tagPairs['Black'] == pgn.tagPairs['Black'], true);
    expect(gamePgn.tagPairs['White'] == pgn.tagPairs['White'], true);
    expect(gamePgn.moveText == pgn.moveText, true);
    expect(gamePgn.tagPairs['Result'] == pgn.tagPairs['Result'], true);
  });

  test('An IratusGame is correctly created from PGN without moves but FEN.',
      () {
    String pgnString = '''[Event "Casual game"]
[Site "iratus.fr"]
[Date "2023.10.7"]
[Time "13.54.6"]
[White "Wall-e"]
[Black "Bumblebee"]
[Result "*"]
[SetUp "1"]
[FEN "fd(0)s(0)yys(1)d(1)g/rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR/FD(2)S(2)YYS(3)D(3)G b QKqk e3 1000000000000000-0000000000000000 0 1"]
[Variant "Iratus"]

''';
    IratusPGN pgn = IratusPGN.fromString(pgnString);
    IratusGame game = IratusGame.fromPGN(pgnString);
    IratusPGN gamePgn = game.getPGN();

    expect(gamePgn.tagPairs['Black'] == pgn.tagPairs['Black'], true);
    expect(gamePgn.tagPairs['White'] == pgn.tagPairs['White'], true);
    expect(gamePgn.moveText == pgn.moveText, true);
    expect(gamePgn.tagPairs['Result'] == pgn.tagPairs['Result'], true);
  });

  test('An IratusGame is correctly created from PGN with moves and FEN.', () {
    String pgnString = '''[Event "Casual game"]
[Site "iratus.fr"]
[Date "2023.10.7"]
[Time "13.54.6"]
[White "Wall-e"]
[Black "Bumblebee"]
[Result "*"]
[Variant "Iratus"]
[SetUp "1"]
[FEN "fd(0)s(0)yys(1)d(1)g/rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR/FD(2)S(2)YYS(3)D(3)G b QKqk e3 1000000000000000-0000000000000000 0 1"]

1. ... e5''';
    IratusPGN pgn = IratusPGN.fromString(pgnString);
    IratusGame game = IratusGame.fromPGN(pgnString);
    IratusPGN gamePgn = game.getPGN();

    expect(gamePgn.tagPairs['Black'] == pgn.tagPairs['Black'], true);
    expect(gamePgn.tagPairs['White'] == pgn.tagPairs['White'], true);
    expect(gamePgn.moveText == pgn.moveText, true);
    expect(gamePgn.tagPairs['Result'] == pgn.tagPairs['Result'], true);
  });

  test('An IratusGame is correctly created from PGN with complex moves.', () {
    // Complex moves are checks, promotions and pieces moving twice
    String pgnString = '''[Event "Casual game"]
[Site "iratus.fr"]
[Date "2023.10.7"]
[Time "13.54.6"]
[White "Wall-e"]
[Black "Bumblebee"]
[Result "*"]
[Variant "Iratus"]

1. e4 d6 2. e6 Qd7 3. exf7+ Kd8 4. fxg8 d5 5. gxf9=Q Cxf9-Cg9''';
    IratusPGN pgn = IratusPGN.fromString(pgnString);
    IratusGame game = IratusGame.fromPGN(pgnString);
    IratusPGN gamePgn = game.getPGN();

    expect(gamePgn.tagPairs['Black'] == pgn.tagPairs['Black'], true);
    expect(gamePgn.tagPairs['White'] == pgn.tagPairs['White'], true);
    expect(gamePgn.moveText == pgn.moveText, true);
    expect(gamePgn.tagPairs['Result'] == pgn.tagPairs['Result'], true);
  });

  test('An IratusGame is correctly finished from PGN with checkmate.', () {
    // Complex moves are checks, promotions and pieces moving twice
    String pgnString = '''[Event "Casual game"]
[Site "iratus.fr"]
[Date "2023.10.7"]
[Time "13.54.6"]
[White "Wall-e"]
[Black "Bumblebee"]
[Result "0-1"]
[Variant "Iratus"]

1. f3 e5 2. g4 Qh4# 0-1''';
    IratusPGN pgn = IratusPGN.fromString(pgnString);
    IratusGame game = IratusGame.fromPGN(pgnString);
    IratusPGN gamePgn = game.getPGN();

    expect(gamePgn.tagPairs['Black'] == pgn.tagPairs['Black'], true);
    expect(gamePgn.tagPairs['White'] == pgn.tagPairs['White'], true);
    expect(gamePgn.moveText == pgn.moveText, true);
    expect(gamePgn.tagPairs['Result'] == pgn.tagPairs['Result'], true);
  });
}
