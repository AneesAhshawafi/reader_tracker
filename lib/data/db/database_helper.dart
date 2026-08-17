import 'dart:async';

import 'package:path/path.dart';
import 'package:reader_tracker/data/models/book.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = 'books_database.db';
  static const _databaseVersion = 1;
  static const _tableName = 'books';

  DatabaseHelper._privateConstructor();
  // singleton pattern
  static final DatabaseHelper getInstance =
      DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database?> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
 CREATE TABLE $_tableName (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        authors TEXT NOT NULL,
        favorite INTEGER DEFAULT 0,
        publisher TEXT,
        publishedDate TEXT,
        description TEXT,
        industryIdentifiers TEXT,
        pageCount INTEGER,
        language TEXT,
        imageLinks TEXT,
        previewLink TEXT,
        infoLink TEXT
      )
''');
  }

  Future<int> insert(Book book) async {
    if (!await isSaved(book.id)) {
      Database db = await getInstance.database;
      return await db.insert(_tableName, book.toJson());
    }
    return 0;
  }

  Future<bool> isSaved(String id) async {
    Database db = await getInstance.database;
    dynamic book = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (!book.isNotEmpty) {
      return false;
    }
    return true;
  }

  Future<List<Book>> readAllBooks() async {
    Database db = await getInstance.database;
    var books = await db.query(_tableName);
    return books.isNotEmpty
        ? books.map((bookData) => Book.fromJsonDatabase(bookData)).toList()
        : [];
  }

  Future<int> toggleFavoritesStatus(String id, bool isFavorite) async {
    Database db = await getInstance.database;
    return await db.update(
      _tableName,
      {'favorite': isFavorite ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> isFavorite(String id) async {
    Database db = await getInstance.database;
    dynamic book = await db.query(
      _databaseName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    book = Book.fromJsonDatabase(book[0]);
    bool isFavorite = book.isFavorite;
    return isFavorite;
  }

  Future<int> deleteBook(String id) async {
    Database db = await getInstance.database;
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Book>> getFavorites() async {
    Database db = await getInstance.database;
    final favoritesBooks = await db.query(_tableName, where: 'favorite = 1');
    return favoritesBooks.isNotEmpty
        ? favoritesBooks
              .map((favoritesBook) => Book.fromJsonDatabase(favoritesBook))
              .toList()
        : [];
  }
}
