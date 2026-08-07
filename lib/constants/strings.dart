import 'package:reader_tracker/env/env.dart';

final String apiKey = Env.booksApiKey;
final url = 'https://www.googleapis.com/books/v1/volumes?q=flutter&key=$apiKey';
