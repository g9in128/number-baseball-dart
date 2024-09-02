import 'io_manager.dart';

class Game {
  late IoManager _ioManager;

  Game() {
    _ioManager = IoManager();
  }

  void start() {
    var menu = _ioManager.initialMenu();

    switch (menu) {}
  }
}
