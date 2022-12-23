import 'package:db_sqflite/db_sqflite.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:movie_core/movie_core.dart';

@GenerateMocks([
  MovieRepository,
  MovieLocalDataSource,
  MovieRemoteDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockClient),
])
void main() {}
