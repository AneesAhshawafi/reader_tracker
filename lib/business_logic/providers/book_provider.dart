import 'package:flutter/material.dart';
import 'package:reader_tracker/data/db/database_helper.dart';
import 'package:reader_tracker/data/models/book.dart';
import 'package:reader_tracker/data/repository/book_repositiry.dart';
// import 'package:sqflite/sqflite.dart';

class BookProvider extends ChangeNotifier {
  List<Book> _books = [];
  List<Book> _savedBooks = [];
  List<Book> _favoritesBooks = [];

  bool _isSearchLoading = false;
  bool _isSavedLoading = false;
  bool _isFavorieLoading = false;

  final BookRepositiry bookRepositiry;
  bool get isSearchLoading => _isSearchLoading;
  bool get isSavedLoading => _isSavedLoading;
  bool get isFavoriteLoading => _isFavorieLoading;

  List<Book> get books => _books;
  List<Book> get savedBooks => _savedBooks;
  List<Book> get favoritesBooks => _favoritesBooks;

  BookProvider({required this.bookRepositiry});
  Future<void> loadFavorites() async {
    _isFavorieLoading = true;
    notifyListeners();

    _favoritesBooks = await DatabaseHelper.getInstance.getFavorites();

    _isFavorieLoading = false;
    notifyListeners();
  }

  Future<void> loadSavedBooks() async {
    _isSavedLoading = true;
    notifyListeners();

    _savedBooks = await DatabaseHelper.getInstance.readAllBooks();

    _isSavedLoading = false;
    notifyListeners();
  }

  Future<void> loadBooks(String query) async {
    _isSearchLoading = true;
    notifyListeners();

    _books = await bookRepositiry.getSearchedForBooks(query);

    _isSearchLoading = false;
    notifyListeners();
  }

  Future<void> toggleFavoritesStatus(Book book) async {
    book.isFavorite = !book.isFavorite;
    await DatabaseHelper.getInstance.toggleFavoritesStatus(
      book.id,
      book.isFavorite,
    );

    // Update in-memory list
    final index = _books.indexWhere((b) => b.id == book.id);
    if (index != -1) {
      _books[index].isFavorite = book.isFavorite;
    }
    await loadFavorites();
    await loadSavedBooks();
    notifyListeners();
  }

  Future<void> deleteBook(String id) async {
    await DatabaseHelper.getInstance.deleteBook(id);
    await loadSavedBooks();
    notifyListeners();
  }
}
