import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/movie_viewmodel.dart';
import '../widgets/movie_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MovieViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text('MovieDB'),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () => Navigator.pushNamed(context, '/saved'),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => Navigator.pushNamed(context, '/search'),
          ),
        ],
      ),
      body:
          vm.isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Section(title: 'Trending', movies: vm.trending),
                    Section(title: 'Now Playing', movies: vm.nowPlaying),
                  ],
                ),
              ),
    );
  }
}

class Section extends StatelessWidget {
  final String title;
  final List movies;

  Section({required this.title, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (_, i) => MovieCard(movie: movies[i]),
            ),
          ),
        ],
      ),
    );
  }
}
