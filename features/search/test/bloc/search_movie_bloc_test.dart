import 'package:bloc_test/bloc_test.dart';
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_domain/movie_domain.dart';
import 'package:search/search.dart';

import '../dummy_data/dummy_movie.dart';
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
    const tQuery = 'query';

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
      act: (bloc) => bloc.add(const SearchMovieOnQueryChanged(query: tQuery)),
      expect: () => <SearchMovieState>[
        const SearchMovieInProgress(),
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
            .thenAnswer((_) async => const Right(<Movie>[]));
        return bloc;
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) => bloc.add(const SearchMovieOnQueryChanged(query: tQuery)),
      expect: () => <SearchMovieState>[
        const SearchMovieInProgress(),
        const SearchMovieEmpty(),
      ],
      verify: (_) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );

    blocTest<SearchMovieBloc, SearchMovieState>(
      'should emit [SearchMovieFailure] when added SearchMovieOnQueryChanged event',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => const Left(ServerFailure('Not found')));
        return bloc;
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) => bloc.add(const SearchMovieOnQueryChanged(query: tQuery)),
      expect: () => <SearchMovieState>[
        const SearchMovieInProgress(),
        const SearchMovieFailure(message: 'Not found'),
      ],
      verify: (_) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );
  });
}
