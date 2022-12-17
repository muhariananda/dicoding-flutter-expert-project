import 'package:bloc_test/bloc_test.dart';
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';
import 'package:tv_series_domain/tv_series_domain.dart';

import '../dummy_data/dummy_tv_series.dart';
import 'search_tv_series_bloc_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late SearchTvSeriesBloc bloc;
  late MockSearchTvSeries mockSearchTvSeries;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    bloc = SearchTvSeriesBloc(
      searchTvSeries: mockSearchTvSeries,
    );
  });

  group('Search tv series,', () {
    const tquery = 'query';

    test('initial state should be [SearchTvSeriesInitial]', () {
      expect(bloc.state, SearchTvSeriesInitial());
    });

    blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
      'should emits [SearchTvSeriesSuccess] when added SearchTvSeriesOnQueryChanged event',
      build: () {
        when(mockSearchTvSeries.execute(tquery))
            .thenAnswer((_) async => Right(testTvSeriesList));
        return bloc;
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) =>
          bloc.add(const SearchTvSeriesOnQueryChanged(query: tquery)),
      expect: () => <SearchTvSeriesState>[
        const SearchTvSeriesInProgress(),
        SearchTvSeriesSuccess(tvSeries: testTvSeriesList)
      ],
      verify: (_) {
        verify(mockSearchTvSeries.execute(tquery));
      },
    );

    blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
      'should emits [SearchTvSeriesEmpty] when added SearchTvSeriesOnQueryChanged event',
      build: () {
        when(mockSearchTvSeries.execute(tquery))
            .thenAnswer((_) async => const Right(<TvSeries>[]));
        return bloc;
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) =>
          bloc.add(const SearchTvSeriesOnQueryChanged(query: tquery)),
      expect: () => <SearchTvSeriesState>[
        const SearchTvSeriesInProgress(),
        const SearchTvSeriesEmpty(),
      ],
      verify: (_) {
        verify(mockSearchTvSeries.execute(tquery));
      },
    );

    blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
      'should emits [SearchTvSeriesFailure] when added SearchTvSeriesOnQueryChanged event',
      build: () {
        when(mockSearchTvSeries.execute(tquery))
            .thenAnswer((_) async => const Left(ServerFailure('Not found')));
        return bloc;
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) =>
          bloc.add(const SearchTvSeriesOnQueryChanged(query: tquery)),
      expect: () => <SearchTvSeriesState>[
        const SearchTvSeriesInProgress(),
        const SearchTvSeriesFailure(message: 'Not found'),
      ],
      verify: (_) {
        verify(mockSearchTvSeries.execute(tquery));
      },
    );
  });
}
