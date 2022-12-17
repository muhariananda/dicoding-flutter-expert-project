import 'package:db_sqflite/db_sqflite.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:movie_domain/movie_domain.dart';
import 'package:movie_repository/movie_repository.dart';

@GenerateMocks([
  MovieRepository,
  MovieLocalDataSource,
  MovieRemoteDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockClient),
])
void main() {}
