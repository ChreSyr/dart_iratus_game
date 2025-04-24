import 'package:dart_iratus_game/dart_iratus_game.dart';
import 'package:test/test.dart';

void main() {
  IratusGame game = IratusGame();

  Piece dogB0 = game.board.getPiece(Position.fromCoords(game.board, 'b0'))!;
  Piece soldierC0 = game.board.getPiece(Position.fromCoords(game.board, 'c0'))!;

  Piece dogG0 = game.board.getPiece(Position.fromCoords(game.board, 'g0'))!;
  Piece soldierF0 = game.board.getPiece(Position.fromCoords(game.board, 'f0'))!;

  Piece dogB9 = game.board.getPiece(Position.fromCoords(game.board, 'b9'))!;
  Piece soldierC9 = game.board.getPiece(Position.fromCoords(game.board, 'c9'))!;

  Piece dogG9 = game.board.getPiece(Position.fromCoords(game.board, 'g9'))!;
  Piece soldierF9 = game.board.getPiece(Position.fromCoords(game.board, 'f9'))!;

  Piece wPhantom = game.board.getPiece(Position.fromCoords(game.board, 'a0'))!;
  Piece bPhantom = game.board.getPiece(Position.fromCoords(game.board, 'a9'))!;

  test('From standart start, dogs and soldiers are correctly linked.', () {
    expect(dogB0.linkedPiece == soldierC0, true);
    expect(dogG0.linkedPiece == soldierF0, true);
    expect(dogB9.linkedPiece == soldierC9, true);
    expect(dogG9.linkedPiece == soldierF9, true);
  });

  test('When a soldier moves around the dog, the dog stays in place.', () {
    game.move('Nf3');
    game.move('Nc6');
    game.move('h4');
    game.move('Sb8');

    expect(game.board.getPiece(Position.fromCoords(game.board, 'b8')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'b8'))!.id ==
            Role.soldier,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'c9')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'b9')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'b9'))!.id ==
            Role.dog,
        true);
  });

  test('When a soldier moves far away from the dog, the dog follows.', () {
    game.move('Sh2');

    expect(game.board.getPiece(Position.fromCoords(game.board, 'h2')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'h2'))!.id ==
            Role.soldier,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'f0')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'g0')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'g1')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'g1'))!.id ==
            Role.dog,
        true);
  });

  test('When a soldier dies, the dog enrages.', () {
    game.move('a5');
    game.move('Sf4');
    game.move('Sa7');
    game.move('Se5');
    game.move('Nxe5');

    expect(game.board.getPiece(Position.fromCoords(game.board, 'e5')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'e5'))!.id ==
            Role.knight,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'f4')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'f4'))!.id ==
            Role.enragedDog,
        true);
  });

  test('The phantom of the previous capture is a soldier.', () {
    expect(wPhantom.id == Role.soldier, true);
  });

  test('When a dog dies, the soldier dies too.', () {
    game.move('Nxe5');
    game.move('Sc5');
    game.move('Nc4');
    game.move('Ye+f9');
    game.move('Nxb6');

    expect(game.board.getPiece(Position.fromCoords(game.board, 'b6')) is Piece,
        true);
    expect(
        game.board.getPiece(Position.fromCoords(game.board, 'b6'))!.id ==
            Role.knight,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'c5')) == null,
        true);
  });

  test('The phantom of the previous capture is an enraged dog.', () {
    expect(bPhantom.id == Role.enragedDog, true);
  });

  test('When a dog dies, if the soldier is dynamited, the capturer dies too.',
      () {
    game.move('Qc9');
    game.move('Nxd7');
    game.move('Kd8');
    game.move('Nf6');
    game.move('Sd7');
    game.move('Nxe8*');

    expect(game.board.getPiece(Position.fromCoords(game.board, 'e8')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'd7')) == null,
        true);
    expect(game.board.getPiece(Position.fromCoords(game.board, 'f6')) == null,
        true);
  });

  test('The phantom of the previous capture is an enraged dog.', () {
    expect(bPhantom.id == Role.enragedDog, true);
    expect(wPhantom.id == Role.knight, true);
  });

  test('When a soldier promotes, the promotion is shown on the notation.', () {
    game.undo();
    game.move('g3');
    game.move('Sf5');
    game.move('B+e0');
    game.move('Sh3');
    game.move('Gg1');
    game.move('Sf1');
    game.move('Gh0');
    game.move('Sg0=E');

    expect(game.board.lastMove!.notation == 'Sg0=E+', true);
  });
}
