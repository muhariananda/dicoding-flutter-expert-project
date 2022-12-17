import 'package:bloc_test/bloc_test.dart';
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series_domain/tv_series_domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_list/tv_series_list.dart';

import '../dummy_tv_series.dart';
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
        when(mockGetNowPlayingTvSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return cubit;
      },
      act: (cubit) => cubit.fetchNowPlayingTvSeries(),
      expect: () => [
        const NowPayingTvSeriesFailure('Server Failure'),
      ],
      verify: (_) {
        verify(mockGetNowPlayingTvSeries.execute());
      },
    );
  });
}
