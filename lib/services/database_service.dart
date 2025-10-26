import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/article.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('news_reader.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      author TEXT,
      title TEXT NOT NULL,
      description TEXT,
      url TEXT UNIQUE NOT NULL,
      urlToImage TEXT,
      publishedAt TEXT,
      sourceName TEXT,
      savedAt TEXT
      )
      ''');
  }

  // Add article to favorites
  Future<int> addFavorite(Article article) async {
    final db = await database;
    try {
      return await db.insert(
        'favorites',
        article.toDatabase(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw Exception('Failed to add favorite: $e');
    }
  }

  // Get all favorites
  Future<List<Article>> getFavorites() async {
    final db = await database;
    final result = await db.query('favorites', orderBy: 'savedAt DESC');
    return result.map((json) => Article.fromDatabase(json)).toList();
  }

  // Check if article is favorite
  Future<bool> isFavorite(String url) async {
    final db = await database;
    final result = await db.query(
      'favorites',
      where: 'url = ?',
      whereArgs: [url],
    );
    return result.isNotEmpty;
  }

  // Remove from favorites
  Future<int> removeFavorite(String url) async {
    final db = await database;
    return await db.delete('favorites', where: 'url = ?', whereArgs: [url]);
  }

  // Clear all favorites
  Future<void> clearAllFavorites() async {
    final db = await database;
    await db.delete('favorites');
  }

  // Close database
  Future close() async {
    final db = await database;
    db.close();
  }
}
