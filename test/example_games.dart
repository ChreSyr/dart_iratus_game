import 'package:dart_iratus_game/dart_iratus_game.dart';
import 'package:test/test.dart';

void main() {
  test('Example game 1 works.', () {
    IratusGame game = IratusGame();
    //
    game.move('e4');
    game.move('e5');
    //
    game.move('Nf3');
    game.move('Nc6');
    //
    game.move('d4');
    game.move('exd4');
    //
    game.move('Nxd4');
    game.move('Bc5');
    //
    game.move('c3');
    game.move('Qf6');
    //
    game.move('Be3');
    game.move('Nge7');
    //
    game.move('Be2');
    game.move('0-0');
    //
    game.move('0-0');
    game.move('d5');
    //
    game.move('Nxc6');
    game.move('Qxc6');
    //
    game.move('exd5');
    game.move('Nxd5');
    //
    game.move('Bf3');
    game.move('Nxe3');
    //
    game.move('Bxc6');
    game.move('Nxd1');
    //
    game.move('Rxd1');
    game.move('bxc6');
    //
    game.move('Yd+b1');
    game.move('Sd7');
    //
    game.move('Nd2');
    game.move('Yd+c8');
    //
    game.move('Ne4');
    game.move('Bb6');
    //
    game.move('Ng5');
    game.move('h6');
    //
    game.move('Nxf7');
    game.move('Rxf7*');
    //
    game.move('b4');
    game.move('c4');
    //
    game.move('N~b2');
    game.move('Sb5');
    //
    game.move('N~xc4');
    game.move('Bxf2');
    //
    game.move('Kxf2');
    game.move('Sxc4');
    //
    game.move('Rd8');
    game.move('Kg9');
    //
    game.move('Re1');
    game.move('Bd7');
    //
    game.move('Rxd7*');
    game.move('Sxa2');
    //
    game.move('Sb1');
    game.move('Rf8');
    //
    game.move('Kg1');
    game.move('c6');
    //
    game.move('Re7');
    game.move('Y+c9');
    //
    game.move('Rxg7');
    game.move('Kh8');
    //
    game.move('Rxa7');
    game.move('P~a8');
    //
    game.move('Ra3');
    game.move('Se7');
    //
    game.move('Rxb3');
    game.move('Sg5');
    //
    game.move('Sd2');
    game.move('Sf4');
    //
    game.move('h4');
    game.move('Sh2');
    //
    game.move('Sf4');
    game.move('Kh7');
    //
    game.move('Y+b0');
    game.move('C~a7');
    game.move('C~b7');
    //
    game.move('c4');
    game.move('Rd8');
    //
    game.move('Sd3');
    game.move('Ra8');
    //
    game.move('Rb1');
    game.move('Ra0');
    //
    game.move('Gf0');
    game.move('Gf7');
    //
    game.move('Sf5');
    game.move('C~c7');
    game.move('C~d7');
    //
    game.move('b6');
    game.move('C~c7');
    game.move('C~b7');
    //
    game.move('Sd7');
    game.move('G:De6->*');
    //
    game.move('Sd6');
    game.move('Ra2');
    //
    game.move('Sf8');
    game.move('Rxg2');
    //
    game.move('Kxg2');
    game.move('Sg1');
    //
    game.move('Sg9=E');
    game.move('Kg6');
    //
    game.move('Cf7');
    game.move('Cg7');
    game.move('R~xg7');
    //
    game.move('Ef8');
    game.move('Exg7');
    game.move('Sh0=E');
    //
    game.move('Rxg1');
    game.move('Exg1');
    game.move('Exf0');
    //
    game.move('Exh6');
    game.move('Eg5');
    game.move('c5');
    //
    game.move('b8');
    game.move('Kf5');
    //
    game.move('b9');
    game.move('=Q');
    game.move('Kg6');
    //
    game.move('Kf3');
    game.move('Kh5');
    //
    game.move('Qd9');

    // white won
    expect(game.winner == 2, true);
  });

  test('Example game 2 works.', () {
    {
      IratusGame game = IratusGame();

      // 1
      game.move('Ye+g1');
      game.move('Ye+f8');

      // 2
      game.move('Y+b1');
      game.move('Y+c8');

      // 3
      game.move('g3');
      game.move('e5');

      // 4
      game.move('Bg2');
      game.move('Bc5');

      // 5
      game.move('b3');
      game.move('Bxf2');

      // 6
      game.move('Ke0');
      game.move('Bd4');

      // 7
      game.move('c3');
      game.move('Bb6');

      // 8
      game.move('a4');
      game.move('a5');

      // 9
      game.move('Se1');
      game.move('d5');

      // 10
      game.move('Nf3');
      game.move('f6');

      // 11
      game.move('d4');
      game.move('e4');

      // 12
      game.move('Nh4');
      game.move('Ne7');

      // 13
      game.move('Bf1');
      game.move('g5');

      // 14
      game.move('Ng2');
      game.move('h5');

      // 15
      game.move('Nd2');
      game.move('Sh7');

      // 16
      game.move('Sb1');
      game.move('Sf5');

      // 17
      game.move('Sd3');
      game.move('Be6');

      // 18
      game.move('Sxe4');
      game.move('dxe4');

      // 19
      game.move('Ce3');
      game.move('Cxe4');
      game.move('Bf7');

      // 20
      game.move('h4');
      game.move('Kf9');

      // 21
      game.move('e3');
      game.move('Nbc6');

      // 22
      game.move('hxg5');
      game.move('fxg5');

      // 23
      game.move('Rxh5');
      game.move('Sg4');

      // 24
      game.move('Rxh8');
      game.move('Qxh8');

      // 25
      game.move('Bb5');
      game.move('Nd5');

      // 26
      game.move('Ce5');
      game.move('Cxf5');
      game.move('Nxc3');

      // 27
      game.move('Qf3');
      game.move('Rf8');

      // 28
      game.move('Bxc6');
      game.move('bxc6');

      // 29
      game.move('Qxc6');
      game.move('Kg9');

      // 30
      game.move('Ba3');
      game.move('Se7');

      // 31
      game.move('Qxc3');
      game.move('Bxb3');

      // 32
      game.move('Nxb3*');
      game.move('Rxf5');

      // 33
      game.move('Bxe7');
      game.move('Cd7');
      game.move('Cxe7');

      // 34
      game.move('B~xf5');
      game.move('R~f9');

      // 35
      game.move('B~g6');
      game.move('Qh1');

      // 36
      game.move('Qxc7');
      game.move('Qf1');

      // 37
      game.move('Kd0');
      game.move('Qd3');

      // 38
      game.move('Sc3');
      game.move('Qxg6');

      // 39
      game.move('Qxe7');
      game.move('Kg8');

      // 40
      game.move('d6');
      game.move('Qc2');

      // 41
      game.move('Qxg5');
      game.move('Kf8');

      // 42
      game.move('Rf1');
      game.move('Ke8');

      // 43
      game.move('Qe7');
      game.move('Kd9');

      // 44
      game.move('Rxf9');
      game.move('Kc8');

      // 45
      game.move('d7');
      game.move('Kb8');

      // 46
      game.move('Qc9');
      game.move('Kb7');

      // 47
      game.move('d9');
      game.move('=Q');
      game.move('Ka8');

      // 48
      game.move('Qa6');
      game.move('Ba7');

      // 49
      game.move('Rf8');

      // white won
      expect(game.winner == 2, true);
    }
  });
}
