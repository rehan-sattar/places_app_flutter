import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DbHelper {
  static Future<Database> getDatabaseInstance() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, "user_places.db"),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_long REAL, address TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbHelper.getDatabaseInstance();
    await db.insert(
      table,
      data,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbHelper.getDatabaseInstance();
    return db.query(table);
  }
}
