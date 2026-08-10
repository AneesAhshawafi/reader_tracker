import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reader_tracker/business_logic/providers/book_provider.dart';
import 'package:reader_tracker/data/models/book.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<Book> books = [];
  // void loadBooks(BookProvider bookProvider, String query) async {
  //   bookProvider.changeLoading();
  //   books = await bookProvider.getSearchedForBooks(query);
  //   bookProvider.changeLoading();
  // }

  @override
  void initState() {
    super.initState();

    // Runs safely right after the initial frame finishes building
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<BookProvider>(context, listen: false).loadBooks("flutter");
    // });
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
            child: bookProvider.isLoading
                ? CircularProgressIndicator()
                : bookProvider.books.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: bookProvider.books.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text(
                            bookProvider.books[index].title.isNotEmpty
                                ? bookProvider.books[index].title[0]
                                : '',
                          ),
                          title: Text(
                            bookProvider.books[index].title.isNotEmpty
                                ? bookProvider.books[index].title
                                : '',
                          ),
                          subtitle: Text(
                            bookProvider.books[index].authors.isNotEmpty
                                ? bookProvider.books[index].authors.join(', & ')
                                : '',
                          ),
                        );
                      },
                    ),
                  )
                : Text("Search for books"),
          ),
        ],
      ),
    );
  }
}
