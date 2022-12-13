// Mocks generated by Mockito 5.3.2 from annotations
// in ditonton/test/feature/movie_list/page/movie_list_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;

import 'package:ditonton/core/movie/domain/usecase/get_now_playing_movies.dart'
    as _i2;
import 'package:ditonton/core/movie/domain/usecase/get_popular_movies.dart'
    as _i4;
import 'package:ditonton/core/movie/domain/usecase/get_top_rated_movies.dart'
    as _i6;
import 'package:ditonton/feature/movie_list/cubit/now_playing_movie_cubit.dart'
    as _i3;
import 'package:ditonton/feature/movie_list/cubit/popular_movie_cubit.dart'
    as _i5;
import 'package:ditonton/feature/movie_list/cubit/top_rated_movie_cubit.dart'
    as _i7;
import 'package:flutter_bloc/flutter_bloc.dart' as _i9;
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

class _FakeGetNowPlayingMovies_0 extends _i1.SmartFake
    implements _i2.GetNowPlayingMovies {
  _FakeGetNowPlayingMovies_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeNowPlayingMovieState_1 extends _i1.SmartFake
    implements _i3.NowPlayingMovieState {
  _FakeNowPlayingMovieState_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetPopularMovies_2 extends _i1.SmartFake
    implements _i4.GetPopularMovies {
  _FakeGetPopularMovies_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakePopularMovieState_3 extends _i1.SmartFake
    implements _i5.PopularMovieState {
  _FakePopularMovieState_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetTopRatedMovies_4 extends _i1.SmartFake
    implements _i6.GetTopRatedMovies {
  _FakeGetTopRatedMovies_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTopRatedMovieState_5 extends _i1.SmartFake
    implements _i7.TopRatedMovieState {
  _FakeTopRatedMovieState_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [NowPlayingMovieCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockNowPlayingMovieCubit extends _i1.Mock
    implements _i3.NowPlayingMovieCubit {
  MockNowPlayingMovieCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetNowPlayingMovies get getNowPlayingMovies => (super.noSuchMethod(
        Invocation.getter(#getNowPlayingMovies),
        returnValue: _FakeGetNowPlayingMovies_0(
          this,
          Invocation.getter(#getNowPlayingMovies),
        ),
      ) as _i2.GetNowPlayingMovies);
  @override
  _i3.NowPlayingMovieState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeNowPlayingMovieState_1(
          this,
          Invocation.getter(#state),
        ),
      ) as _i3.NowPlayingMovieState);
  @override
  _i8.Stream<_i3.NowPlayingMovieState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i8.Stream<_i3.NowPlayingMovieState>.empty(),
      ) as _i8.Stream<_i3.NowPlayingMovieState>);
  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);
  @override
  _i8.Future<void> fetchNowPlayingMovie() => (super.noSuchMethod(
        Invocation.method(
          #fetchNowPlayingMovie,
          [],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
  @override
  void emit(_i3.NowPlayingMovieState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onChange(_i9.Change<_i3.NowPlayingMovieState>? change) =>
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
  _i8.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
}

/// A class which mocks [PopularMovieCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockPopularMovieCubit extends _i1.Mock implements _i5.PopularMovieCubit {
  MockPopularMovieCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.GetPopularMovies get getPopularMovies => (super.noSuchMethod(
        Invocation.getter(#getPopularMovies),
        returnValue: _FakeGetPopularMovies_2(
          this,
          Invocation.getter(#getPopularMovies),
        ),
      ) as _i4.GetPopularMovies);
  @override
  _i5.PopularMovieState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakePopularMovieState_3(
          this,
          Invocation.getter(#state),
        ),
      ) as _i5.PopularMovieState);
  @override
  _i8.Stream<_i5.PopularMovieState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i8.Stream<_i5.PopularMovieState>.empty(),
      ) as _i8.Stream<_i5.PopularMovieState>);
  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);
  @override
  _i8.Future<void> fetchPopularMovies() => (super.noSuchMethod(
        Invocation.method(
          #fetchPopularMovies,
          [],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
  @override
  void emit(_i5.PopularMovieState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onChange(_i9.Change<_i5.PopularMovieState>? change) =>
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
  _i8.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
}

/// A class which mocks [TopRatedMovieCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockTopRatedMovieCubit extends _i1.Mock
    implements _i7.TopRatedMovieCubit {
  MockTopRatedMovieCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.GetTopRatedMovies get getTopRatedMovies => (super.noSuchMethod(
        Invocation.getter(#getTopRatedMovies),
        returnValue: _FakeGetTopRatedMovies_4(
          this,
          Invocation.getter(#getTopRatedMovies),
        ),
      ) as _i6.GetTopRatedMovies);
  @override
  _i7.TopRatedMovieState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeTopRatedMovieState_5(
          this,
          Invocation.getter(#state),
        ),
      ) as _i7.TopRatedMovieState);
  @override
  _i8.Stream<_i7.TopRatedMovieState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i8.Stream<_i7.TopRatedMovieState>.empty(),
      ) as _i8.Stream<_i7.TopRatedMovieState>);
  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);
  @override
  _i8.Future<void> fetchTopRatedMovie() => (super.noSuchMethod(
        Invocation.method(
          #fetchTopRatedMovie,
          [],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
  @override
  void emit(_i7.TopRatedMovieState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onChange(_i9.Change<_i7.TopRatedMovieState>? change) =>
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
  _i8.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
}
