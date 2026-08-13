import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reader_tracker/business_logic/providers/book_provider.dart';
import 'package:reader_tracker/pages/widgets/grid_view_widget.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  void initState() {
    super.initState();
    loadSavedBooks();
  }

  Future<void> loadSavedBooks() async {
    await Provider.of<BookProvider>(context, listen: false).loadSavedBooks();
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    return Center(
      child: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextField(
          //     decoration: const InputDecoration(
          //       hintText: "Search for books ...",
          //       suffixIcon: Icon(Icons.search),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.all(Radius.circular(10)),
          //       ),
          //     ),
          //     onSubmitted: (query) {
          //       searchForBooks(query);
          //     },
          //   ),
          // ),
          SizedBox(height: 10),
          Container(
            // margin: EdgeInsets.only(top: 10),
            child: bookProvider.isLoading
                ? CircularProgressIndicator()
                : bookProvider.books.isNotEmpty
                ? GridViewWidget(books: bookProvider.savedBooks)
                : Text("No saved books yet"),
          ),
        ],
      ),
    );
  }
}
