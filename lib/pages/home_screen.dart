import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reader_tracker/business_logic/providers/book_provider.dart';
import 'package:reader_tracker/pages/widgets/grid_view_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> searchForBooks(String query) async {
    await Provider.of<BookProvider>(context, listen: false).loadBooks(query);
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search for books ...",
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              onSubmitted: (query) {
                searchForBooks(query);
              },
            ),
          ),
          Container(
            child: bookProvider.isSearchLoading
                ? CircularProgressIndicator()
                : bookProvider.books.isNotEmpty
                ? GridViewWidget()
                : Text("Search for books"),
          ),
        ],
      ),
    );
  }
}
