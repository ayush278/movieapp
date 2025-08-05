import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../data/models/movie.dart';

class LocalDb {
  late Database _db;

  Future<LocalDb> init() async {
    final path = join(await getDatabasesPath(), 'movies.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE movies(id INTEGER PRIMARY KEY, title TEXT, poster_path TEXT, overview TEXT, release_date TEXT);',
        );
        db.execute(
          'CREATE TABLE bookmarks(id INTEGER PRIMARY KEY, title TEXT, poster_path TEXT, overview TEXT, release_date TEXT);',
        );
      },
    );
    return this;
  }

  Future<void> insertMovies(List<Movie> movies) async {
    for (var movie in movies) {
      await _db.insert(
        'movies',
        movie.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Movie>> getAllMovies() async {
    final maps = await _db.query('movies');
    return maps.map((e) => Movie.fromJson(e)).toList();
  }

  Future<void> bookmark(Movie movie) async {
    await _db.insert(
      'bookmarks',
      movie.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> unbookmark(int id) async {
    await _db.delete('bookmarks', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Movie>> getBookmarks() async {
    final maps = await _db.query('bookmarks');
    return maps.map((e) => Movie.fromJson(e)).toList();
  }
}
