import "dart:io";

import "session.dart";

class IoManager {
  int? _numberInput() {
    var inputS = stdin.readLineSync() ?? "";
    var input = int.tryParse(inputS);
    return input;
  }

  List<int>? _numberListInput([bool passwd = false]) {
    List<int> input = [];
    late List<String> inputSL;
    if (passwd) {
      inputSL = [];

      stdin.echoMode = false;
      stdin.lineMode = false;

      var test = <int>[];
      while (true) {
        var char = stdin.readByteSync();
        test.add(char);
        if (char == 10 || char == 13) {
          break;
        }
        if (char == 8 || char == 127) {
          inputSL.removeLast();
          stdout.write("\b \b");
        } else {
          inputSL.add(String.fromCharCode(char));
          stdout.write("*");
        }
      }
      print("");
      print(test);
      stdin.lineMode = true;
      stdin.echoMode = true;
    } else {
      var inputS = stdin.readLineSync() ?? "";
      inputSL = inputS.split("");
    }
    for (var str in inputSL) {
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

1. 혼자 플레이하기
2. 둘이서 플레이하기
3. 종료 하기
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
      var name = session.player;
      if (name != null) {
        name += "의";
      }
      print(
          "\n\n\x1B[2J\x1B[0;0H=========================\n${name ?? ''}질문 현황");
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
      if (question.isNotEmpty) {
        print("현재 입력값 : ${question.join(" ")}");
      }
      stdout.write(">");

      var tmpList = _numberListInput();
      Set<int> checkMulti = {};
      for (var i in tmpList ?? List<int>.empty()) {
        checkMulti.add(i);
      }
      if (tmpList == null || checkMulti.length != tmpList.length) {
        capa = 0;
        question.clear();
        cancel = true;
      } else {
        capa += tmpList.length;
        question.addAll(tmpList);
      }
    }
    return question;
  }

  Session makePlayerView(String defaultName) {
    stdout.write(
        "\x1B[2J\x1B[0;0H$defaultName의 이름을 설정하세요(기본값 : $defaultName)\n>");
    var name = stdin.readLineSync() ?? defaultName;
    if (name.isEmpty) name = defaultName;
    var answer = <int>[];
    var cancel = false;
    while (answer.length != 4) {
      if (cancel) print("\x1B[2J\x1B잘못된 값을 입력하였습니다!");
      print("생각한 0부터 9까지 숫자 4개를 입력하세요.");
      stdout.write("숫자 : ");
      answer = _numberListInput(true) ?? <int>[];
      cancel = true;
    }
    Session session = Session(answer, name);
    return session;
  }
}
