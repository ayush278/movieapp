import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../data/models/movie.dart';
import '../../viewmodels/movie_viewmodel.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Movie;
    final vm = context.watch<MovieViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share('Check out this movie: myapp://movie/${movie.id}');
            },
          ),
          IconButton(
            icon: Icon(
              vm.bookmarks.any((m) => m.id == movie.id)
                  ? Icons.bookmark
                  : Icons.bookmark_border,
            ),
            onPressed: () => vm.toggleBookmark(movie),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (movie.posterPath != null)
                Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                ),
              SizedBox(height: 10),
              Text(
                movie.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(movie.overview ?? 'No overview available'),
              SizedBox(height: 10),
              Text('Release Date: ${movie.releaseDate ?? "N/A"}'),
            ],
          ),
        ),
      ),
    );
  }
}
