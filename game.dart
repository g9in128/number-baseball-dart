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
        case 5:
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
    print("정답!\n계속하시려 아무 키나 누르십시오...");
    stdin.readLineSync();
  }
}
