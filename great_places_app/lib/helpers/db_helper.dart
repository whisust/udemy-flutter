import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static const PLACES_TABLE = 'user_places';

  static Future<void> _createDb(Database db, int version) {
    return db.execute(
        'CREATE TABLE $PLACES_TABLE(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, loc_address TEXT)',
        );
  }

  static Future<Database> _getDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'places.db'), onCreate: _createDb, version: 1);
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final sqlDb = await _getDatabase();
    await sqlDb.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final sqlDb = await _getDatabase();
    return sqlDb.query(table); // , orderBy: 'id DESC'
  }
}
