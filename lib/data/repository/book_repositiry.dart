// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:reader_tracker/data/models/book.dart';
import 'package:reader_tracker/data/web_services/book_web_service.dart';

class BookRepositiry {
  final BookWebService bookWebService;
  BookRepositiry({required this.bookWebService});

  Future<List<Book>> getSearchedForBooks(String query) async {
    final booksMap = await bookWebService.getSearchedForBooks(query);
    return booksMap.map((book) => Book.fromJson(book)).toList();
  }
}
