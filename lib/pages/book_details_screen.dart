import 'package:flutter/material.dart';
import 'package:reader_tracker/data/models/book.dart';
import 'package:reader_tracker/pages/widgets/web_cros_image.dart';

class BookDetailsScreen extends StatefulWidget {
  final Book book;
  const BookDetailsScreen({super.key, required this.book});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var textTheme2 = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Details"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          // color: Theme.of(context).colorScheme.secondary,
          // padding: EdgeInsets.symmetric(horizontal: 5),
          child: ListView(
            children: [
              // Wrap with Expanded so it takes the available Column height
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(6),
              //     child: WebCORSImage(
              //       width: 200,
              //       imageUrl: widget.book.imageLinks['thumbnail']!,
              //       // fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              Padding(
                padding: EdgeInsetsGeometry.all(8.0),

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: WebCORSImage(
                    width: 200,
                    height: 250,
                    imageUrl: widget.book.imageLinks['thumbnail']!,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.book.title,
                  textAlign: TextAlign.center,
                  style: textTheme2.headlineLarge,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.book.authors.isNotEmpty
                      ? widget.book.authors.join(', & ')
                      : '',
                  textAlign: TextAlign.center,
                  style: textTheme2.bodyLarge,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  widget.book.publishedDate.isNotEmpty
                      ? "Published Date: ${widget.book.publishedDate}"
                      : '',
                  textAlign: TextAlign.center,
                  style: textTheme2.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "Language: ${widget.book.language}",
                  textAlign: TextAlign.center,
                  style: textTheme2.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
