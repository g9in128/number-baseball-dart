import "dart:io";

import "session.dart";

class IoManager {
  int? numberInput() {
    var input_s = stdin.readLineSync() ?? "";
    var input = int.tryParse(input_s);
    return input;
  }

  int initialMenu() {
    var menu = -1;
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
    menu = numberInput() ?? -1;
    return menu;
  }

  List<int> askQuestionView(Session session) {
    List<int> question = [];
    var capa = 0;
    var cancel = false;
    while (capa < 4) {
      print("\x1B[2J\x1B[0;0H질문 현황");
      var log = session.log;
      for (var i = 0; i < log.length; i++) {
        var res = log[i];
        if (res != null) {
          print("${res.question} => ${res.strikes} Strike , ${res.balls} Ball");
        }
      }
      if (cancel) {
        print("입력 값 오류! 입력 초기화");
        cancel = false;
      }
      print("질문을 입력하세요!");
      if (!question.isEmpty) {
        print("현재 입력값 : ${question.join(" ")}");
      }
      stdout.write(">");

      var input = numberInput() ?? -1;
      if (input < 0) {
        capa = 0;
        question.clear();
        cancel = true;
        continue;
      }
    }
    return question;
  }
}
