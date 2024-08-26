import 'database_manager.dart';

class IOManager {
  
  DatabaseManager _databaseManager;
  
  IOManager(this._databaseManager);

	void printTitle() {
		print('''------------------------
숫자야구 게임! by g9in128

1. 혼자 한다(play alone).
2. 친구랑 한다(play with a friend).
3. 기록을 본다(view the record).
4. 규칙을 본다(see how to play).
5. 로그인 한다(log in).
------------------------
>''');
  	}
}