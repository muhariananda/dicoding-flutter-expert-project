import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/core/movie/domain/entities/movie.dart';
import 'package:ditonton/core/movie/domain/usecase/search_movies.dart';
import 'package:ditonton/feature/search/bloc/search_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movie/dummy_movie.dart';
import 'search_movie_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late SearchMovieBloc bloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    bloc = SearchMovieBloc(
      searchMovies: mockSearchMovies,
    );
  });

  group('Search movies', () {
    final tQuery = 'query';

    test('initial state should be [SearchMoviesIntial]', () {
      expect(bloc.state, SearchMoviesIntial());
    });

    blocTest<SearchMovieBloc, SearchMovieState>(
      'should emit [SearchMovieSuccess] when added SearchMovieOnQueryChanged event',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(testMovieList));
        return bloc;
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) => bloc.add(SearchMovieOnQueryChanged(query: tQuery)),
      expect: () => <SearchMovieState>[
        SearchMovieInProgress(),
        SearchMovieSuccess(movies: testMovieList),
      ],
      verify: (_) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );

    blocTest<SearchMovieBloc, SearchMovieState>(
      'should emit [SearchMovieEmpty] when added SearchMovieOnQueryChanged event',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(<Movie>[]));
        return bloc;
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) => bloc.add(SearchMovieOnQueryChanged(query: tQuery)),
      expect: () => <SearchMovieState>[
        SearchMovieInProgress(),
        SearchMovieEmpty(),
      ],
      verify: (_) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );

    blocTest<SearchMovieBloc, SearchMovieState>(
      'should emit [SearchMovieFailure] when added SearchMovieOnQueryChanged event',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Not found')));
        return bloc;
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) => bloc.add(SearchMovieOnQueryChanged(query: tQuery)),
      expect: () => <SearchMovieState>[
        SearchMovieInProgress(),
        SearchMovieFailure(message: 'Not found'),
      ],
      verify: (_) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );
  });
}
