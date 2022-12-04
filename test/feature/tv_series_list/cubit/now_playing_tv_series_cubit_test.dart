import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_now_playing_tv_series.dart';
import 'package:ditonton/feature/tv_series_list/cubit/now_playing_tv_series_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_series/dummy_tv_series.dart';
import 'now_playing_tv_series_cubit_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries])
void main() {
  late NowPlayingTvSeriesCubit cubit;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;

  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    cubit = NowPlayingTvSeriesCubit(
      getNowPlayingTvSeries: mockGetNowPlayingTvSeries,
    );
  });

  group('Get now playing tv series,', () {
    test('initial state should be [Loading]', () {
      expect(cubit.state, NowPayingTvSeriesInProgress());
    });

    blocTest<NowPlayingTvSeriesCubit, NowPlayingTvSeriesState>(
      'should emit [Success] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        return cubit;
      },
      act: (cubit) => cubit.fetchNowPlayingTvSeries(),
      expect: () => [NowPayingTvSeriesSuccess(testTvSeriesList)],
      verify: (_) {
        verify(mockGetNowPlayingTvSeries.execute());
      },
    );

    blocTest<NowPlayingTvSeriesCubit, NowPlayingTvSeriesState>(
      'should emit [Error] when data is gotten unsuccessful',
      build: () {
        when(mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return cubit;
      },
      act: (cubit) => cubit.fetchNowPlayingTvSeries(),
      expect: () => [
        NowPayingTvSeriesFailure('Server Failure'),
      ],
      verify: (_) {
        verify(mockGetNowPlayingTvSeries.execute());
      },
    );
  });
}
