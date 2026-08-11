import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reader_tracker/business_logic/providers/book_provider.dart';
import 'package:reader_tracker/data/models/book.dart';
import 'package:reader_tracker/pages/widgets/web_cros_image.dart';

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

  String getWebSafeImageUrl(String originalUrl) {
    if (originalUrl.isEmpty) return '';

    // 1. Convert http to https
    String secureUrl = originalUrl.replaceFirst('http://', 'https://');

    // 2. Wrap with a CORS proxy service
    return 'https://corsproxy.io/?${Uri.encodeComponent(secureUrl)}';
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
                    child: SizedBox(
                      width: double.infinity,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: bookProvider.books.length,
                        itemBuilder: (context, index) {
                          Book book = bookProvider.books[index];

                          String imageUrl = book.imageLinks['thumbnail'] ?? '';
                          if (imageUrl.startsWith('http://')) {
                            imageUrl = imageUrl.replaceFirst(
                              'http://',
                              'https://',
                            );
                          }

                          return Container(
                            width: double.infinity,
                            // padding: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceContainer,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(6),
                              ),
                              border: Border.all(
                                width: 2,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                            child: Column(
                              children: [
                                // Wrap with Expanded so it takes the available Column height
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: WebCORSImage(
                                      width: 200,
                                      imageUrl: imageUrl,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    book.title,
                                    textAlign: TextAlign.start,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleSmall,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    book.authors.isNotEmpty
                                        ? book.authors.join(', & ')
                                        : '',
                                    textAlign: TextAlign.start,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                // If you add Title/Text below the image later, it will sit here cleanly
                              ],
                            ),
                          );
                        },
                      ),
                      // ListView.builder(
                      //   itemCount: bookProvider.books.length,
                      //   itemBuilder: (context, index) {
                      //     return ListTile(
                      //       leading: Text(
                      //         bookProvider.books[index].title.isNotEmpty
                      //             ? bookProvider.books[index].title[0]
                      //             : '',
                      //       ),
                      //       title: Text(
                      //         bookProvider.books[index].title.isNotEmpty
                      //             ? bookProvider.books[index].title
                      //             : '',
                      //       ),
                      //       subtitle: Text(
                      //         bookProvider.books[index].authors.isNotEmpty
                      //             ? bookProvider.books[index].authors.join(
                      //                 ', & ',
                      //               )
                      //             : '',
                      //       ),
                      //     );
                      //   },
                      // ),
                    ),
                  )
                : Text("Search for books"),
          ),
        ],
      ),
    );
  }
}
