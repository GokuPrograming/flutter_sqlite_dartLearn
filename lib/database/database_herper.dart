import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._internal();
  static DatabaseHelper get instance =>
      _databaseHelper ??= DatabaseHelper._internal();

  Database? _db;
  Future<Database> get db async {
    if (_db == null) {
      await init(); // Inicializa la base de datos si aún no está inicializada
    }
    return _db!;
  }

  /// Inicializa la base de datos
  Future<void> init() async {
    String path = join(await getDatabasesPath(), 'database.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name varchar(100),imagen text NOT NULL DEFAULT '' )');
      },
    );
  }
}
