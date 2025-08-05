import 'package:flutter/material.dart';
import '../data/models/movie.dart';
import '../data/repositories/movie_repository.dart';

class MovieViewModel extends ChangeNotifier {
  final MovieRepository repo;

  List<Movie> trending = [];
  List<Movie> nowPlaying = [];
  List<Movie> searchResults = [];
  List<Movie> bookmarks = [];
  bool isLoading = false;

  MovieViewModel(this.repo) {
    loadHome();
    loadBookmarks();
  }

  void loadHome() async {
    isLoading = true;
    notifyListeners();
    trending = await repo.getTrending();
    nowPlaying = await repo.getNowPlaying();
    isLoading = false;
    notifyListeners();
  }

  void search(String query) async {
    searchResults = await repo.search(query);
    notifyListeners();
  }

  void loadBookmarks() async {
    bookmarks = await repo.getBookmarked();
    notifyListeners();
  }

  void toggleBookmark(Movie movie) async {
    if (bookmarks.any((m) => m.id == movie.id)) {
      await repo.unbookmark(movie.id);
    } else {
      await repo.bookmark(movie);
    }
    loadBookmarks();
  }
}
