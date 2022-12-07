// Mocks generated by Mockito 5.3.2 from annotations
// in ditonton/test/feature/watchlist/cubit/watchlist_tv_series_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:ditonton/common/failure.dart' as _i6;
import 'package:ditonton/core/tv_series/domain/entities/tv_series.dart' as _i7;
import 'package:ditonton/core/tv_series/domain/repositories/tv_series_repository.dart'
    as _i2;
import 'package:ditonton/core/tv_series/domain/usecase/get_watchlist_tv_series.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeTvSeriesRepository_0 extends _i1.SmartFake
    implements _i2.TvSeriesRepository {
  _FakeTvSeriesRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetWatchListTvSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListTvSeries extends _i1.Mock
    implements _i4.GetWatchListTvSeries {
  MockGetWatchListTvSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvSeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvSeriesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TvSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>> execute() =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.TvSeries>>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>>);
}
