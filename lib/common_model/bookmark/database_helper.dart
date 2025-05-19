import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {

    if(_database != null) return _database!;

    _database = await _initDB("app1.db");

    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {

    await db.execute('''
      CREATE TABLE bookmark(
        id TEXT NOT NULL,
        type TEXT NOT NULL,
        objectMap TEXT NOT NULL
      )
    ''');

      await db.execute('''
      CREATE TABLE bookmark_test(
        id TEXT NOT NULL,
        type TEXT NOT NULL,
        objectMap TEXT NOT NULL
      )
    ''');
  }
}