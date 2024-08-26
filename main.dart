import 'database_manager.dart';
import 'iomanager.dart';

void main() {
	DatabaseManager dbManager = DatabaseManager();
	IOManager ioManager = IOManager(dbManager);

	ioManager.printTitle();
}