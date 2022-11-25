import 'package:ditonton/core/tv_series/domain/usecase/get_watchlist_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockRepository;
  late GetWatchlistStatus usecase;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = GetWatchlistStatus(mockRepository);
  });

  final tId = 1;

  test('should get watchlist status from the repository ', () async {
    //arrange
    when(mockRepository.isAddedToWatchlist(tId)).thenAnswer((_) async => true);

    //act
    final result = await usecase.execute(tId);

    //assert
    expect(result, true);
  });
}
