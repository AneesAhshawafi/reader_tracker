import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reader_tracker/business_logic/providers/book_provider.dart';
import 'package:reader_tracker/constants/strings.dart';
import 'package:reader_tracker/data/models/book.dart';

class GridViewWidget extends StatefulWidget {
  const GridViewWidget({
    super.key,
    this.isSaved = false,
    this.isFavorite = false,
  });

  final bool isSaved;
  final bool isFavorite;

  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    final booksList = widget.isSaved
        ? bookProvider.savedBooks
        : widget.isFavorite
        ? bookProvider.favoritesBooks
        : bookProvider.books;
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
          ),
          itemCount: booksList.length,
          itemBuilder: (context, index) {
            Book book = booksList[index];

            String imageUrl = book.imageLinks['thumbnail'] ?? '';
            if (imageUrl.startsWith('http://')) {
              imageUrl = imageUrl.replaceFirst('http://', 'https://');
            }

            return Container(
              width: double.infinity,
              // padding: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(
                    context,
                  ).pushNamed(bookDetailsScreenRoute, arguments: book);
                },
                child: Column(
                  children: [
                    // Wrap with Expanded so it takes the available Column height
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(imageUrl, fit: BoxFit.contain),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        book.title,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.titleSmall,
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
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    widget.isSaved
                        ? Container(
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.inversePrimary,
                              border: Border.all(
                                width: 2,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    try {
                                      await bookProvider.toggleFavoritesStatus(
                                        book,
                                      );
                                      SnackBar snackBar = SnackBar(
                                        content: Text(
                                          book.isFavorite
                                              ? "Book was added to favorites"
                                              : "Book was removed from favorites",
                                        ),
                                        duration: Duration(seconds: 1),
                                      );
                                      if (mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(snackBar);
                                      }
                                    } catch (e) {
                                      SnackBar snackBar = SnackBar(
                                        content: Text(
                                          "error happend while toggling the book: ${e.toString()} ",
                                        ),
                                      );
                                      if (mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(snackBar);
                                      }
                                    }
                                  },
                                  icon: Icon(
                                    book.isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined,
                                    color: Colors.redAccent,
                                    size: 30,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    try {
                                      await bookProvider.deleteBook(book.id);
                                      SnackBar snackBar = SnackBar(
                                        content: Text("Book was deleted"),
                                        duration: Duration(seconds: 1),
                                      );
                                      if (mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(snackBar);
                                      }
                                    } catch (e) {
                                      SnackBar snackBar = SnackBar(
                                        content: Text(
                                          "error happend while saving the book: ${e.toString()} ",
                                        ),
                                      );
                                      if (mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(snackBar);
                                      }
                                    }
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ],
                            ),
                          )
                        : Text(""),
                    widget.isFavorite
                        ? IconButton(
                            onPressed: () async {
                              try {
                                await bookProvider.toggleFavoritesStatus(book);
                                SnackBar snackBar = SnackBar(
                                  content: Text(
                                    book.isFavorite
                                        ? "Book was added to favorites"
                                        : "Book was removed from favorites",
                                  ),
                                  duration: Duration(seconds: 1),
                                );
                                if (mounted) {
                                  ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(snackBar);
                                }
                              } catch (e) {
                                SnackBar snackBar = SnackBar(
                                  content: Text(
                                    "error happend while toggling the book: ${e.toString()} ",
                                  ),
                                );
                                if (mounted) {
                                  ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(snackBar);
                                }
                              }
                            },
                            icon: Icon(
                              book.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color: Colors.redAccent,
                              size: 30,
                            ),
                          )
                        : Text(""),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
