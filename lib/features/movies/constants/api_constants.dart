const String baseUrl = 'https://api.themoviedb.org';
const String myApiKey = '381c6f552c337f0ecdf967ae2eb294e9';

String getTrendingUrl() {
  return '$baseUrl/3/trending/movie/day?api_key=$myApiKey';
}

String getTopRatedUrl() {
  return '$baseUrl/3/movie/top_rated?api_key=$myApiKey';
}

String getUpcomingUrl() {
  return '$baseUrl/3/movie/upcoming?api_key=$myApiKey';
}

class ImgConstants {
  static const imgPath = 'https://image.tmdb.org/t/p/w500';
}
