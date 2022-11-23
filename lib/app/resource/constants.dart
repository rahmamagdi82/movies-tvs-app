import 'package:movies/app/resource/language_manager.dart';

class AppConstants {

  static const int splashDelay=3;

  static const String baseUrl="https://api.themoviedb.org/3";
  static const String apiKey="9920cb9dd1247da7510b251a4b8f6fb0";
  static const String baseImagePath="https://image.tmdb.org/t/p/w500";

  // movies
  static String getPlayingMoviesPath()=>"$baseUrl/movie/now_playing?api_key=$apiKey&language=${getAppLanguage()}";
  static String getPopularMoviesPath()=>"$baseUrl/movie/popular?api_key=$apiKey&language=${getAppLanguage()}";
  static String getTopRatingMoviesPath()=>"$baseUrl/movie/top_rated?api_key=$apiKey&language=${getAppLanguage()}";
  static String getMovieDetailsPath(int id) => "$baseUrl/movie/$id?api_key=$apiKey&language=${getAppLanguage()}";
  static String getRecommendationMoviePath(int id) => "$baseUrl/movie/$id/recommendations?api_key=$apiKey&language=${getAppLanguage()}";

  // tv
  static String getOnAirTvPath()=>"$baseUrl/tv/on_the_air?api_key=$apiKey&language=${getAppLanguage()}";
  static String getPopularTvPath()=>"$baseUrl/tv/popular?api_key=$apiKey&language=${getAppLanguage()}";
  static String getTopRatingTvPath()=>"$baseUrl/tv/top_rated?api_key=$apiKey&language=${getAppLanguage()}";
  static String getTvDetailsPath(int id) => "$baseUrl/tv/$id?api_key=$apiKey&language=${getAppLanguage()}";
  static String getRecommendationTvPath(int id) => "$baseUrl/tv/$id/recommendations?api_key=$apiKey&language=${getAppLanguage()}";
  static String getSeasonsTvPath(int id,int seasonNumber) => "$baseUrl/tv/$id/season/$seasonNumber?api_key=$apiKey&language=${getAppLanguage()}";
}