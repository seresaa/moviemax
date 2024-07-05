import 'package:flutter_dotenv/flutter_dotenv.dart';

String getTrendingUrl() {
  return '${dotenv.env['BASE_URL']}/3/trending/movie/day?api_key=${dotenv.env['API_KEY']}';
}

String getTopRatedUrl() {
  return '${dotenv.env['BASE_URL']}/3/movie/top_rated?api_key=${dotenv.env['API_KEY']}';
}

String getUpcomingUrl() {
  return '${dotenv.env['BASE_URL']}/3/movie/upcoming?api_key=${dotenv.env['API_KEY']}';
}

String getRecommendedUrl(String movieId) {
  return '${dotenv.env['BASE_URL']}/3/movie/${movieId}/recommendations?api_key=${dotenv.env['API_KEY']}';
}

class ImgConstants {
  static const imgPath = 'https://image.tmdb.org/t/p/w500';
}
