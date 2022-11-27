class UrlBuilder {
  const UrlBuilder({
    String? baseUrl,
    String? apiKey,
  })  : _baseUrl = baseUrl ?? 'https://api.themoviedb.org/3',
        _apiKey = apiKey ?? '2174d146bb9c0eab47529b2e77d6b526';

  final String _baseUrl;
  final String _apiKey;

  Uri buildGetNowPlayingMoviesUrl() {
    return Uri.parse('$_baseUrl/movie/now_playing?api_key=$_apiKey');
  }

  Uri buildGetPopularMoviesUrl() {
    return Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey');
  }

  Uri buildGetTopRatedMoviesUrl() {
    return Uri.parse('$_baseUrl/movie/top_rated?api_key=$_apiKey');
  }

  Uri buildGetMovieDetailUrl(int id) {
    return Uri.parse('$_baseUrl/movie/$id?api_key=$_apiKey');
  }

  Uri buildGetRecommendationsMovieUrl(int id) {
    return Uri.parse('$_baseUrl/movie/$id/recommendations?api_key=$_apiKey');
  }

  Uri buildSearchMoviesUrl(String query) {
    return Uri.parse('$_baseUrl/search/movie?api_key=$_apiKey&query=$query');
  }

  Uri buildGetNowPlayingTvSeriesUrl() {
    return Uri.parse('$_baseUrl/tv/on_the_air?api_key=$_apiKey');
  }

  Uri buildGetPopularTvSeriesUrl() {
    return Uri.parse('$_baseUrl/tv/popular?api_key=$_apiKey');
  }

  Uri buildGetTopRatedTvSeriesUrl() {
    return Uri.parse('$_baseUrl/tv/top_rated?api_key=$_apiKey');
  }

  Uri buildGetDetailTvSeriesUrl(int id) {
    return Uri.parse('$_baseUrl/tv/$id?api_key=$_apiKey');
  }

  Uri buildGetRecommendationsTvSeriesUrl(int id) {
    return Uri.parse('$_baseUrl/tv/$id/recommendations?api_key=$_apiKey');
  }

  Uri buildSearchTvSeriesUrl(String query) {
    return Uri.parse('$_baseUrl/search/tv?api_key=$_apiKey&query=$query');
  }
}
