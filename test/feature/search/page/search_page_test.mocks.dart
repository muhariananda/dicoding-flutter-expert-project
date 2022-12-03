// Mocks generated by Mockito 5.3.2 from annotations
// in ditonton/test/feature/search/page/search_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i9;
import 'dart:ui' as _i10;

import 'package:ditonton/common/content_selection.dart' as _i5;
import 'package:ditonton/common/state_enum.dart' as _i6;
import 'package:ditonton/core/movie/domain/entities/movie.dart' as _i7;
import 'package:ditonton/core/movie/domain/usecase/search_movies.dart' as _i2;
import 'package:ditonton/core/tv_series/domain/entities/tv_series.dart' as _i8;
import 'package:ditonton/core/tv_series/domain/usecase/search_tv_series.dart'
    as _i3;
import 'package:ditonton/feature/search/provider/search_notifier.dart' as _i4;
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

class _FakeSearchMovies_0 extends _i1.SmartFake implements _i2.SearchMovies {
  _FakeSearchMovies_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSearchTvSeries_1 extends _i1.SmartFake
    implements _i3.SearchTvSeries {
  _FakeSearchTvSeries_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [SearchNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchNotifier extends _i1.Mock implements _i4.SearchNotifier {
  MockSearchNotifier() {
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
  _i3.SearchTvSeries get searchTvSeries => (super.noSuchMethod(
        Invocation.getter(#searchTvSeries),
        returnValue: _FakeSearchTvSeries_1(
          this,
          Invocation.getter(#searchTvSeries),
        ),
      ) as _i3.SearchTvSeries);
  @override
  _i5.ContentSelection get selectedContent => (super.noSuchMethod(
        Invocation.getter(#selectedContent),
        returnValue: _i5.ContentSelection.movie,
      ) as _i5.ContentSelection);
  @override
  _i6.RequestState get movieState => (super.noSuchMethod(
        Invocation.getter(#movieState),
        returnValue: _i6.RequestState.Empty,
      ) as _i6.RequestState);
  @override
  List<_i7.Movie> get movieSearchResult => (super.noSuchMethod(
        Invocation.getter(#movieSearchResult),
        returnValue: <_i7.Movie>[],
      ) as List<_i7.Movie>);
  @override
  _i6.RequestState get tvSeriesState => (super.noSuchMethod(
        Invocation.getter(#tvSeriesState),
        returnValue: _i6.RequestState.Empty,
      ) as _i6.RequestState);
  @override
  List<_i8.TvSeries> get tvSeriesSearchResult => (super.noSuchMethod(
        Invocation.getter(#tvSeriesSearchResult),
        returnValue: <_i8.TvSeries>[],
      ) as List<_i8.TvSeries>);
  @override
  String get message => (super.noSuchMethod(
        Invocation.getter(#message),
        returnValue: '',
      ) as String);
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  _i9.Future<void> fetchMovieSearch(String? query) => (super.noSuchMethod(
        Invocation.method(
          #fetchMovieSearch,
          [query],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);
  @override
  _i9.Future<void> fetchTvSeriesSearch(String? query) => (super.noSuchMethod(
        Invocation.method(
          #fetchTvSeriesSearch,
          [query],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);
  @override
  void setSelectedContent(_i5.ContentSelection? content) => super.noSuchMethod(
        Invocation.method(
          #setSelectedContent,
          [content],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addListener(_i10.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i10.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
