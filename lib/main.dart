import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/movie_viewmodel.dart';
import 'ui/pages/home_page.dart';
import 'ui/pages/detail_page.dart';
import 'ui/pages/saved_movies_page.dart';
import 'ui/pages/search_page.dart';
import 'data/services/api_service.dart';
import 'data/repositories/movie_repository.dart';
import 'db/local_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localDb = await LocalDb().init();

  final dio = Dio(
      BaseOptions(
        baseUrl: "https://api.themoviedb.org/3",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Accept': 'application/json', 'User-Agent': 'MovieApp/1.0.0'},
      ),
    )
    ..interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );

  final apiService = ApiService(dio);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MovieViewModel(MovieRepository(apiService, localDb)),
        ),
      ],
      child: MovieApp(),
    ),
  );
}

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovieDB',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => HomePage(),
        '/detail': (_) => DetailPage(),
        '/saved': (_) => SavedMoviesPage(),
        '/search': (_) => SearchPage(),
      },
    );
  }
}
