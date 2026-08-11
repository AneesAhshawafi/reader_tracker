import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reader_tracker/constants/strings.dart';

class BookWebService {
  Future<List<dynamic>> getSearchedForBooks(String query) async {
    try {
      // final uri = Uri.https(baseUrl, "/volumes", {'q': query, 'key': apiKey});
      // final uri = Uri.parse("$baseUrl/volumes?q={$query}&key={$apiKey}");
      // final uri = Uri.parse(
      //   "https://www.googleapis.com/books/v1/volumes?q=flutter&key=$apiKey",
      // );
      final uri = Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=$query&key=$apiKey",
      );
      // print("Uri============================================================");
      // print(uri.toString());
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final books = data['items'];
        // print(
        //   "books============================================================",
        // );
        // print(books.toString());
        return books;
      }

      return [];
    } catch (e) {
      print(
        "catch============================================================",
      );
      print(e.toString());
      return [];
    }
  }
}
