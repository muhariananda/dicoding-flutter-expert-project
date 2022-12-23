import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_core/tv_series_core.dart';

import '../../test_helper/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockRepository;
  late GetWatchlistStatus usecase;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = GetWatchlistStatus(mockRepository);
  });

  const tId = 1;

  test('should get watchlist status from the repository ', () async {
    //arrange
    when(mockRepository.isAddedToWatchlist(tId)).thenAnswer((_) async => true);

    //act
    final result = await usecase.execute(tId);

    //assert
    expect(result, true);
  });
}
