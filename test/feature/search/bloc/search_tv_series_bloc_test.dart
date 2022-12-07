import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/core/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/core/tv_series/domain/usecase/search_tv_series.dart';
import 'package:ditonton/feature/search/bloc/search_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_series/dummy_tv_series.dart';
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
    final tquery = 'query';

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
      act: (bloc) => bloc.add(SearchTvSeriesOnQueryChanged(query: tquery)),
      expect: () => <SearchTvSeriesState>[
        SearchTvSeriesInProgress(),
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
            .thenAnswer((_) async => Right(<TvSeries>[]));
        return bloc;
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) => bloc.add(SearchTvSeriesOnQueryChanged(query: tquery)),
      expect: () => <SearchTvSeriesState>[
        SearchTvSeriesInProgress(),
        SearchTvSeriesEmpty(),
      ],
      verify: (_) {
        verify(mockSearchTvSeries.execute(tquery));
      },
    );

    blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
      'should emits [SearchTvSeriesFailure] when added SearchTvSeriesOnQueryChanged event',
      build: () {
        when(mockSearchTvSeries.execute(tquery))
            .thenAnswer((_) async => Left(ServerFailure('Not found')));
        return bloc;
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) => bloc.add(SearchTvSeriesOnQueryChanged(query: tquery)),
      expect: () => <SearchTvSeriesState>[
        SearchTvSeriesInProgress(),
        SearchTvSeriesFailure(message: 'Not found'),
      ],
      verify: (_) {
        verify(mockSearchTvSeries.execute(tquery));
      },
    );
  });
}
