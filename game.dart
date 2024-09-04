import 'io_manager.dart';
import 'session.dart';

class Game {
  late IoManager _ioManager;
  Session? _session1, _session2;

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
    _session1 = Session.random();
  }
}
