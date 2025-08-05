import 'package:flutter/material.dart';
import '../../data/models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        movie.posterPath != null
            ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
            : null;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: movie);
      },
      child: Container(
        width: 120,
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            imageUrl != null
                ? Image.network(imageUrl, height: 150, fit: BoxFit.cover)
                : Container(
                  alignment: Alignment.center,
                  height: 150,
                  width: 150,
                  color: Colors.grey,
                  child: Text("N/A"),
                ),
            SizedBox(height: 5),
            Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
