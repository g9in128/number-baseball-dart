import "dart:io";

import "session.dart";

class IoManager {
  int? _numberInput() {
    var input_s = stdin.readLineSync() ?? "";
    var input = int.tryParse(input_s);
    return input;
  }

  List<int>? _numberListInput() {
    List<int> input = [];
    var input_s = stdin.readLineSync() ?? "";
    var input_s_l = input_s.split("");
    for (var str in input_s_l) {
      var n = int.tryParse(str);
      if (n != null) {
        input.add(n);
      } else {
        if (str.isNotEmpty) {
          return null;
        }
      }
    }
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
    menu = _numberInput() ?? -1;
    return menu;
  }

  List<int> askQuestionView(Session session) {
    List<int> question = [];
    var capa = 0;
    var cancel = false;
    while (capa < 4) {
      print("\n\x1B[2J\x1B[0;0H=========================\n질문 현황");
      var log = session.log;
      if (log.isEmpty) print("N/A");
      for (var i = 0; i < log.length; i++) {
        var res = log[i];
        if (res != null) {
          print("${res.question} => ${res.strikes} Strike , ${res.balls} Ball");
        }
      }
      print(
          '=========================\n※ 중복된 숫자를 입력하거나 숫자나 공백 이외의 값을 입력하면 입력이 초기화 됩니다.');
      if (cancel) {
        print("입력 값 오류! 입력 초기화");
        cancel = false;
      }
      print("질문을 입력하세요!");
      if (!question.isEmpty) {
        print("현재 입력값 : ${question.join(" ")}");
      }
      stdout.write(">");

      var tmp_list = _numberListInput();
      Set<int> check_multi = {};
      for (var i in tmp_list ?? List<int>.empty()) {
        check_multi.add(i);
      }
      if (tmp_list == null || check_multi.length != tmp_list.length) {
        capa = 0;
        question.clear();
        cancel = true;
      } else {
        capa += tmp_list.length;
        question.addAll(tmp_list);
      }
    }
    return question;
  }
}
