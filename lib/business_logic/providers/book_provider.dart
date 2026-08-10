import 'package:flutter/material.dart';
import 'package:reader_tracker/data/models/book.dart';
import 'package:reader_tracker/data/repository/book_repositiry.dart';

class BookProvider extends ChangeNotifier {
  List<Book> _books = [];
  bool _isLoading = false;
  final BookRepositiry bookRepositiry;
  bool get isLoading => _isLoading;
  List<Book> get books => _books;
  BookProvider({required this.bookRepositiry});
  // void changeLoading() {
  //   _isLoading = !_isLoading;
  //   notifyListeners();
  // }

  Future<void> loadBooks(String query) async {
    _isLoading = true;
    notifyListeners();
    _books = await bookRepositiry.getSearchedForBooks(query);
    _isLoading = false;
    notifyListeners();
  }
}
