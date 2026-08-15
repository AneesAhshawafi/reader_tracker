import 'package:flutter/material.dart';
import 'package:reader_tracker/data/db/database_helper.dart';
import 'package:reader_tracker/data/models/book.dart';
import 'package:reader_tracker/data/repository/book_repositiry.dart';
// import 'package:sqflite/sqflite.dart';

class BookProvider extends ChangeNotifier {
  List<Book> _books = [];
  List<Book> _savedBooks = [];
  bool _isLoading = false;
  final BookRepositiry bookRepositiry;
  bool get isLoading => _isLoading;
  List<Book> get books => _books;
  List<Book> get savedBooks => _savedBooks;
  BookProvider({required this.bookRepositiry});
  
  Future<void> loadBooks(String query) async {
    _isLoading = true;
    notifyListeners();
    _books = await bookRepositiry.getSearchedForBooks(query);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadSavedBooks() async {
    _isLoading = true;
    notifyListeners();
    _savedBooks = await DatabaseHelper.getInstance.readAllBooks();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> toggleFavoritesStatus(String id, bool isFavorite) async {
    final newStatus = !isFavorite;
    await DatabaseHelper.getInstance.toggleFavoritesStatus(id, newStatus);

    // Update in-memory list
    final index = _books.indexWhere((b) => b.id == id);
    if (index != -1) {
      _books[index].isFavorite = newStatus;
    }

    await loadSavedBooks();
    notifyListeners();
  }

 
}
