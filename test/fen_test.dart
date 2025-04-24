import 'package:dart_iratus_game/dart_iratus_game.dart';
import 'package:test/test.dart';

void main() {
  test('standart FEN is correctly read & duplicated', () {
    var standartGame = IratusGame();

    expect(standartGame.board.startFEN.fen == standartGame.board.getFEN().fen,
        true);
  });

  test('en passant is correctly written in FEN', () {
    IratusGame enPassantGame =
        IratusGame.fromFEN('8/4p3/8/3P4/8/2K2k2/8/8/8/8 w - - 0-0 0 1');
    enPassantGame.move('d8');

    expect(
        enPassantGame.board.getFEN().fen ==
            '8/3Pp3/8/8/8/2K2k2/8/8/8/8 b - d7 1-0 0 1',
        true);
  });

  test('en passant FEN is correctly read & duplicated', () {
    IratusGame enPassantGame2 =
        IratusGame.fromFEN('8/3Pp3/8/8/8/2K2k2/8/8/8/8 b - d7 1-0 0 1');

    expect(
        enPassantGame2.board.startFEN.fen == enPassantGame2.board.getFEN().fen,
        true);
    expect(
        enPassantGame2.board.validNotations.join(', ') ==
            'e7, e6, exd7, Kg4, Ke4, Kg5, Kf5, Ke5, Kg3, Kf3, Ke3',
        true);
  });
}
