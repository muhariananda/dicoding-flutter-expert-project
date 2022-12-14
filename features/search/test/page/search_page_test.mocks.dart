// Mocks generated by Mockito 5.3.2 from annotations
// in search/test/page/search_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:flutter_bloc/flutter_bloc.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie_core/movie_core.dart' as _i2;
import 'package:search/src/bloc/search_movie_bloc.dart' as _i3;
import 'package:search/src/bloc/search_tv_series_bloc.dart' as _i5;
import 'package:tv_series_core/tv_series_core.dart' as _i4;

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

class _FakeSearchMovies_0 extends _i1.SmartFake implements _i2.SearchMovies {
  _FakeSearchMovies_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSearchMovieState_1 extends _i1.SmartFake
    implements _i3.SearchMovieState {
  _FakeSearchMovieState_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSearchTvSeries_2 extends _i1.SmartFake
    implements _i4.SearchTvSeries {
  _FakeSearchTvSeries_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSearchTvSeriesState_3 extends _i1.SmartFake
    implements _i5.SearchTvSeriesState {
  _FakeSearchTvSeriesState_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [SearchMovieBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchMovieBloc extends _i1.Mock implements _i3.SearchMovieBloc {
  MockSearchMovieBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SearchMovies get searchMovies => (super.noSuchMethod(
        Invocation.getter(#searchMovies),
        returnValue: _FakeSearchMovies_0(
          this,
          Invocation.getter(#searchMovies),
        ),
      ) as _i2.SearchMovies);
  @override
  _i3.SearchMovieState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeSearchMovieState_1(
          this,
          Invocation.getter(#state),
        ),
      ) as _i3.SearchMovieState);
  @override
  _i6.Stream<_i3.SearchMovieState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i6.Stream<_i3.SearchMovieState>.empty(),
      ) as _i6.Stream<_i3.SearchMovieState>);
  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);
  @override
  void add(_i3.SearchMovieEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onEvent(_i3.SearchMovieEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void emit(_i3.SearchMovieState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void on<E extends _i3.SearchMovieEvent>(
    _i7.EventHandler<E, _i3.SearchMovieState>? handler, {
    _i7.EventTransformer<E>? transformer,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #on,
          [handler],
          {#transformer: transformer},
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onTransition(
          _i7.Transition<_i3.SearchMovieEvent, _i3.SearchMovieState>?
              transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
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
  @override
  void onChange(_i7.Change<_i3.SearchMovieState>? change) => super.noSuchMethod(
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
}

/// A class which mocks [SearchTvSeriesBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchTvSeriesBloc extends _i1.Mock
    implements _i5.SearchTvSeriesBloc {
  MockSearchTvSeriesBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.SearchTvSeries get searchTvSeries => (super.noSuchMethod(
        Invocation.getter(#searchTvSeries),
        returnValue: _FakeSearchTvSeries_2(
          this,
          Invocation.getter(#searchTvSeries),
        ),
      ) as _i4.SearchTvSeries);
  @override
  _i5.SearchTvSeriesState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeSearchTvSeriesState_3(
          this,
          Invocation.getter(#state),
        ),
      ) as _i5.SearchTvSeriesState);
  @override
  _i6.Stream<_i5.SearchTvSeriesState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i6.Stream<_i5.SearchTvSeriesState>.empty(),
      ) as _i6.Stream<_i5.SearchTvSeriesState>);
  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);
  @override
  void add(_i5.SearchTvSeriesEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onEvent(_i5.SearchTvSeriesEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void emit(_i5.SearchTvSeriesState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void on<E extends _i5.SearchTvSeriesEvent>(
    _i7.EventHandler<E, _i5.SearchTvSeriesState>? handler, {
    _i7.EventTransformer<E>? transformer,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #on,
          [handler],
          {#transformer: transformer},
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onTransition(
          _i7.Transition<_i5.SearchTvSeriesEvent, _i5.SearchTvSeriesState>?
              transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
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
  @override
  void onChange(_i7.Change<_i5.SearchTvSeriesState>? change) =>
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
}
