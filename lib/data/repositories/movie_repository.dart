import '../services/api_service.dart';
import '../../db/local_db.dart';
import '../models/movie.dart';
import '../models/movie_response.dart';

class MovieRepository {
  final ApiService api;
  final LocalDb db;
  final String apiKey = "enter api key";

  MovieRepository(this.api, this.db);

  Future<List<Movie>> getTrending() async {
    final MovieResponse response = await api.getTrendingMovies(apiKey);
    await db.insertMovies(response.results);
    return response.results;
  }

  Future<List<Movie>> getNowPlaying() async {
    final MovieResponse response = await api.getNowPlaying(apiKey);
    await db.insertMovies(response.results);
    return response.results;
  }

  Future<List<Movie>> search(String query) async {
    final MovieResponse response = await api.searchMovies(apiKey, query);
    return response.results;
  }

  Future<void> bookmark(Movie movie) => db.bookmark(movie);
  Future<void> unbookmark(int id) => db.unbookmark(id);
  Future<List<Movie>> getBookmarked() => db.getBookmarks();
  Future<List<Movie>> getCachedMovies() => db.getAllMovies();
}
