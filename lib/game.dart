import 'dart:io';

import 'io_manager.dart';
import 'session.dart';

class Game {
  late IoManager _ioManager;

  Game() {
    _ioManager = IoManager();
  }

  void start() {
    bool end = false;
    while (!end) {
      var menu = _ioManager.initialMenu();
      switch (menu) {
        case 1:
          _singlePlay();
          break;
        case 2:
          _twoPlayersPlay();
        case 3:
          end = true;
          break;
      }
    }
  }

  void _singlePlay() {
    var session = Session.random();
    late Result res;
    do {
      res = session.compare(_ioManager.askQuestionView(session));
    } while (res.strikes != 4);
    print("정답!\n계속하시려면 엔터 키를 누르십시오...");
    stdin.readLineSync();
  }

  void _twoPlayersPlay() {
    var p1 = _ioManager.makePlayerView("Player 1");
    var p2 = _ioManager.makePlayerView("Player 2");

    late Result res1, res2;
    do {
      res1 = p1.compare(_ioManager.askQuestionView(p1));
      res2 = p2.compare(_ioManager.askQuestionView(p2));
    } while (res1.strikes != 4 && res2.strikes != 4);

    if (res1.strikes == 4 && res2.strikes == 4) {
      print("비겼습니다!\n계속하시려면 엔터 키를 누르십시오...");
      stdin.readLineSync();
    }
  }
}
