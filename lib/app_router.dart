import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reader_tracker/business_logic/providers/book_provider.dart';
import 'package:reader_tracker/constants/strings.dart';
import 'package:reader_tracker/data/models/book.dart';
import 'package:reader_tracker/data/repository/book_repositiry.dart';
import 'package:reader_tracker/data/web_services/book_web_service.dart';
import 'package:reader_tracker/main_screen.dart';
import 'package:reader_tracker/pages/book_details_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreenRoute:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (BuildContext context) => BookProvider(
              bookRepositiry: BookRepositiry(bookWebService: BookWebService()),
            ),
            child: MainScreen(),
          ),
        );
      case bookDetailsScreenRoute:
        Book book = settings.arguments as Book;
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => BookProvider(
              bookRepositiry: BookRepositiry(bookWebService: BookWebService()),
            ),
            child: BookDetailsScreen(book: book),
          ),
        );
    }
    return null;
  }
}
