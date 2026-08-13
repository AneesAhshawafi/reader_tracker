import 'package:flutter/material.dart';
import 'package:reader_tracker/constants/strings.dart';
import 'package:reader_tracker/data/models/book.dart';
// import 'package:reader_tracker/pages/widgets/web_cros_image.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({super.key, required this.books});

  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
          ),
          itemCount: books.length,
          itemBuilder: (context, index) {
            Book book = books[index];

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
                        // WebCORSImage(
                        //   width: 200,
                        //   imageUrl: imageUrl,
                        //   fit: BoxFit.contain,
                        // ),
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
                    // If you add Title/Text below the image later, it will sit here cleanly
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
