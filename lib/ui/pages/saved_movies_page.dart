import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/movie_viewmodel.dart';
import '../widgets/movie_card.dart';

class SavedMoviesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MovieViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text('Saved Movies')),
      body:
          vm.bookmarks.isEmpty
              ? Center(child: Text('No saved movies'))
              : ListView(
                children: vm.bookmarks.map((m) => MovieCard(movie: m)).toList(),
              ),
    );
  }
}
