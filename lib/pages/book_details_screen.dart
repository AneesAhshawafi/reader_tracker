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
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: double.infinity,
            // color: Theme.of(context).colorScheme.secondary,
            // padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
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
                TextWidget(
                  text: widget.book.title,
                  textStyle: textTheme2.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextWidget(
                  text: "Author/s:${widget.book.authors.join(', & ')}",
                  textStyle: textTheme2.bodyMedium!,
                ),
                TextWidget(
                  text: "Published Date: ${widget.book.publishedDate}",
                  textStyle: textTheme2.bodyLarge!,
                ),

                TextWidget(
                  text: "Language: ${widget.book.language}",
                  textStyle: textTheme2.bodyMedium!,
                ),
                SizedBox(height: 20),
                Row(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.save),
                      label: Text("Saved"),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.favorite),
                      label: Text("Favorites"),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextWidget(
                  text: "Description",
                  textStyle: textTheme2.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: 30),

                  decoration: BoxDecoration(
                    // color: Colors.grey,
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 2, color: Colors.black87),
                  ),
                  child: Text(widget.book.description),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({super.key, required this.text, required this.textStyle});

  final String text;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: textStyle,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
