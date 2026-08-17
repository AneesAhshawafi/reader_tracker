import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reader_tracker/business_logic/providers/book_provider.dart';
import 'package:reader_tracker/pages/widgets/grid_view_widget.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    // Wait until the initial frame finishes building and rendering on screen, and THEN run this code.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookProvider>().loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final bookProvider = context.watch<BookProvider>();
    final bookProvider = Provider.of<BookProvider>(context);
    return Center(
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            // margin: EdgeInsets.only(top: 10),
            child: bookProvider.isFavoriteLoading
                ? CircularProgressIndicator()
                : bookProvider.favoritesBooks.isNotEmpty
                ? GridViewWidget(isFavorite: true)
                : Text("No saved books yet"),
          ),
        ],
      ),
    );
  }
}
