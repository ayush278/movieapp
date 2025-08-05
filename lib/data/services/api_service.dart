import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/movie_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://api.themoviedb.org/3")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/trending/movie/week")
  Future<MovieResponse> getTrendingMovies(@Query("api_key") String apiKey);

  @GET("/movie/now_playing")
  Future<MovieResponse> getNowPlaying(@Query("api_key") String apiKey);

  @GET("/search/movie")
  Future<MovieResponse> searchMovies(
    @Query("api_key") String apiKey,
    @Query("query") String query,
  );
}
