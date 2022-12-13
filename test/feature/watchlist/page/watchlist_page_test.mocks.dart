// Mocks generated by Mockito 5.3.2 from annotations
// in ditonton/test/feature/watchlist/page/watchlist_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:bloc/bloc.dart' as _i7;
import 'package:ditonton/core/movie/domain/usecase/get_watchlist_movies.dart'
    as _i2;
import 'package:ditonton/core/tv_series/domain/usecase/get_watchlist_tv_series.dart'
    as _i4;
import 'package:ditonton/feature/watchlist/cubit/watchlist_movie_cubit.dart'
    as _i3;
import 'package:ditonton/feature/watchlist/cubit/watchlist_tv_series_cubit.dart'
    as _i5;
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

class _FakeGetWatchlistMovies_0 extends _i1.SmartFake
    implements _i2.GetWatchlistMovies {
  _FakeGetWatchlistMovies_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWatchlistMovieState_1 extends _i1.SmartFake
    implements _i3.WatchlistMovieState {
  _FakeWatchlistMovieState_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetWatchListTvSeries_2 extends _i1.SmartFake
    implements _i4.GetWatchListTvSeries {
  _FakeGetWatchListTvSeries_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWatchlistTvSeriesState_3 extends _i1.SmartFake
    implements _i5.WatchlistTvSeriesState {
  _FakeWatchlistTvSeriesState_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [WatchlistMovieCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchlistMovieCubit extends _i1.Mock
    implements _i3.WatchlistMovieCubit {
  MockWatchlistMovieCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetWatchlistMovies get getWatchlistMovies => (super.noSuchMethod(
        Invocation.getter(#getWatchlistMovies),
        returnValue: _FakeGetWatchlistMovies_0(
          this,
          Invocation.getter(#getWatchlistMovies),
        ),
      ) as _i2.GetWatchlistMovies);
  @override
  _i3.WatchlistMovieState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeWatchlistMovieState_1(
          this,
          Invocation.getter(#state),
        ),
      ) as _i3.WatchlistMovieState);
  @override
  _i6.Stream<_i3.WatchlistMovieState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i6.Stream<_i3.WatchlistMovieState>.empty(),
      ) as _i6.Stream<_i3.WatchlistMovieState>);
  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);
  @override
  _i6.Future<void> fetchWatchlistMovies() => (super.noSuchMethod(
        Invocation.method(
          #fetchWatchlistMovies,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  void emit(_i3.WatchlistMovieState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onChange(_i7.Change<_i3.WatchlistMovieState>? change) =>
      super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i6.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
}

/// A class which mocks [WatchlistTvSeriesCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchlistTvSeriesCubit extends _i1.Mock
    implements _i5.WatchlistTvSeriesCubit {
  MockWatchlistTvSeriesCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.GetWatchListTvSeries get getWatchListTvSeries => (super.noSuchMethod(
        Invocation.getter(#getWatchListTvSeries),
        returnValue: _FakeGetWatchListTvSeries_2(
          this,
          Invocation.getter(#getWatchListTvSeries),
        ),
      ) as _i4.GetWatchListTvSeries);
  @override
  _i5.WatchlistTvSeriesState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeWatchlistTvSeriesState_3(
          this,
          Invocation.getter(#state),
        ),
      ) as _i5.WatchlistTvSeriesState);
  @override
  _i6.Stream<_i5.WatchlistTvSeriesState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i6.Stream<_i5.WatchlistTvSeriesState>.empty(),
      ) as _i6.Stream<_i5.WatchlistTvSeriesState>);
  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);
  @override
  _i6.Future<void> fetchWatchlistTvSeries() => (super.noSuchMethod(
        Invocation.method(
          #fetchWatchlistTvSeries,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  void emit(_i5.WatchlistTvSeriesState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onChange(_i7.Change<_i5.WatchlistTvSeriesState>? change) =>
      super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i6.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
}
