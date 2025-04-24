import 'package:dart_iratus_game/dart_iratus_game.dart';
import 'package:test/test.dart';

void main() {
  var game = IratusGame();
  var board = game.board;

  test('Position.fromCoords', () {
    Position pos1 = Position.fromCoords(board, 'a9');
    expect(pos1.coord == 'a9', true);
    expect(pos1.row == 0, true);
    expect(pos1.col == 0, true);
    expect(pos1.index == 0, true);

    Position pos2 = Position.fromCoords(board, 'h0');
    expect(pos2.coord == 'h0', true);
    expect(pos2.row == 9, true);
    expect(pos2.col == 7, true);
    expect(pos2.index == 79, true);

    Position pos3 = Position.fromCoords(board, 'e6');
    expect(pos3.coord == 'e6', true);
    expect(pos3.row == 3, true);
    expect(pos3.col == 4, true);
    expect(pos3.index == 43, true);
  });

  test('Position.fromRowCol', () {
    Position pos1 = Position.fromRowCol(board, row: 0, col: 0);
    expect(pos1.coord == 'a9', true);
    expect(pos1.row == 0, true);
    expect(pos1.col == 0, true);
    expect(pos1.index == 0, true);

    Position pos2 = Position.fromRowCol(board, row: 9, col: 7);
    expect(pos2.coord == 'h0', true);
    expect(pos2.row == 9, true);
    expect(pos2.col == 7, true);
    expect(pos2.index == 79, true);

    Position pos3 = Position.fromRowCol(board, row: 3, col: 4);
    expect(pos3.coord == 'e6', true);
    expect(pos3.row == 3, true);
    expect(pos3.col == 4, true);
    expect(pos3.index == 43, true);
  });

  test('Position.fromIndex', () {
    Position pos1 = Position.fromIndex(board, 0);
    expect(pos1.coord == 'a9', true);
    expect(pos1.row == 0, true);
    expect(pos1.col == 0, true);
    expect(pos1.index == 0, true);

    Position pos2 = Position.fromIndex(board, 79);
    expect(pos2.coord == 'h0', true);
    expect(pos2.row == 9, true);
    expect(pos2.col == 7, true);
    expect(pos2.index == 79, true);

    Position pos3 = Position.fromIndex(board, 43);
    expect(pos3.coord == 'e6', true);
    expect(pos3.row == 3, true);
    expect(pos3.col == 4, true);
    expect(pos3.index == 43, true);
  });
}
