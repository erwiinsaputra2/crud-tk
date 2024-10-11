import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'survey.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'survey.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE survey(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, address TEXT, description TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertSurvey(Survey survey) async {
    final db = await database;
    await db.insert('survey', survey.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Survey>> getSurveys() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('survey');
    return List.generate(maps.length, (i) {
      return Survey.fromMap(maps[i]);
    });
  }

  Future<void> updateSurvey(Survey survey) async {
    final db = await database;
    await db.update('survey', survey.toMap(), where: 'id = ?', whereArgs: [survey.id]);
  }

  Future<void> deleteSurvey(int id) async {
    final db = await database;
    await db.delete('survey', where: 'id = ?', whereArgs: [id]);
  }
}
