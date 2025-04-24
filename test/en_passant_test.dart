import 'package:dart_iratus_game/dart_iratus_game.dart';
import 'package:test/test.dart';

void main() {
  test('En passant works in standart situation', () {
    // In this starting fen, there is two kings, a white pawn and a black pawn.
    // White to move up two squares. Then black to move and capture the pawn.
    IratusGame game =
        IratusGame.fromFEN('8/4p3/8/3P4/8/2K2k2/8/8/8/8 w - - 0-0 0 1');

    game.move('d8');

    expect(game.board.getPiece(Position.fromCoords(game.board, 'e8')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'e8'))!.id ==
            Role.pawn,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd8')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'd8'))!.id ==
            Role.pawn,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd7')) == null,
        true);
    expect(game.board.lastMove!.enPassant != null, true);
    expect(game.board.lastMove!.enPassant!.coord == 'd7', true);

    game.move('exd7');

    expect(game.board.getPiece(Position.fromCoords(game.board, 'e8')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd8')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd7')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'd7'))!.id ==
            Role.pawn,
        true);
    expect(game.board.lastMove!.enPassant == null, true);
  });

  test('En passant at coordinates given by FEN', () {
    // In this starting fen, there is two kings, a white pawn and a black pawn.
    // Black to move and capture the white pawn.
    IratusGame game =
        IratusGame.fromFEN('8/3Pp3/8/8/8/2K2k2/8/8/8/8 b - d7 0-0 0 1');

    expect(game.board.getPiece(Position.fromCoords(game.board, 'e8')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'e8'))!.id ==
            Role.pawn,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd8')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'd8'))!.id ==
            Role.pawn,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd7')) == null,
        true);

    game.move('exd7');

    expect(game.board.getPiece(Position.fromCoords(game.board, 'e8')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd8')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd7')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'd7'))!.id ==
            Role.pawn,
        true);
  });

  test('En passant at coordinates given by FEN (the pawn just promoted)', () {
    // In this starting fen, there is two kings, a white king and a black pawn.
    // Because of the value 'd8' at the fiels 'enPassant', we know thay the queen is a pawn
    // who just promoted after moving two squares. Black to move and capture the queen.
    IratusGame game =
        IratusGame.fromFEN('3Qp3/8/8/8/8/2K2k2/8/8/8/8 b - d8 -0 0 1');

    expect(game.board.getPiece(Position.fromCoords(game.board, 'e9')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'e9'))!.id ==
            Role.pawn,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd9')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'd9'))!.id ==
            Role.queen,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd8')) == null,
        true);

    game.move('exd8');

    expect(game.board.getPiece(Position.fromCoords(game.board, 'e9')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd9')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd8')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'd8'))!.id ==
            Role.pawn,
        true);
  });
}
