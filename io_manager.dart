import "dart:io";

class IoManager {
  int initialMenu() {
    var menu = -1;
    do {
      print("\x1B[2J\x1B[0;0H");
      stdout.write("""-----------------------
숫자야구 게임 by g9in128

1. 혼자 플레이하기 - Single Play
2. 둘이서 플레이하기 - 2P Play
3. 기록 보기 - View the Records
4. 로그인 하기 - Login
5. 종료 하기 - Quit
-----------------------
>""");
      var menu_s = stdin.readLineSync() ?? "-1";
      menu = int.tryParse(menu_s) ?? -1;
    } while (menu < 0 || menu > 5);
    return menu;
  }
}
