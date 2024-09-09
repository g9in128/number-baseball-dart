import 'dart:math';

class Session {
  late List<int> _number;
  late Map<int, Result> _log;

  Session(List<int> number) {
    _number = [];
    var i = 0;
    _log = Map();
    while (_number.length < 4) {
      var value = number[i];
      i += 1;

      if (!_number.contains(value)) {
        _number.add(value);
      }
    }
  }

  Session.random() {
    var random = Random();
    _number = [];
    _log = Map();
    while (_number.length < 4) {
      var value = random.nextInt(10);

      if (!_number.contains(value)) {
        _number.add(value);
      }
    }
  }

  Result compare(List<int> question) {
    var strikes = 0, balls = 0;
    for (var i = 0; i < 4; i++) {
      if (_number[i] == question[i]) {
        strikes += 1;
      } else if (_number.contains(question[i])) {
        balls += 1;
      }
    }
    var res = Result(
      question: question,
      strikes: strikes,
      balls: balls,
    );
    _log[_log.length] = res;
    return res;
  }

  Map<int, Result> get log => _log;
}

class Result {
  late String _question;
  late int _strikes, _balls;

  Result({
    required List<int> question,
    required int strikes,
    required int balls,
  }) {
    _question = question.join();
    _strikes = strikes;
    _balls = balls;
  }

  String get question => _question;

  int get strikes => _strikes;

  int get balls => _balls;
}
