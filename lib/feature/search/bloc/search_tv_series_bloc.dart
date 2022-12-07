import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:ditonton/core/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/core/tv_series/domain/usecase/search_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'search_tv_series_event.dart';
part 'search_tv_series_state.dart';

class SearchTvSeriesBloc
    extends Bloc<SearchTvSeriesEvent, SearchTvSeriesState> {
  final SearchTvSeries searchTvSeries;

  SearchTvSeriesBloc({
    required this.searchTvSeries,
  }) : super(const SearchTvSeriesInitial()) {
    on<SearchTvSeriesOnQueryChanged>(
      (event, emit) async {
        final query = event.query;
        emit(
          SearchTvSeriesInProgress(),
        );

        final result = await searchTvSeries.execute(query);
        result.fold(
          (failure) {
            emit(
              SearchTvSeriesFailure(message: failure.message),
            );
          },
          (tvSeries) {
            if (tvSeries.isNotEmpty) {
              emit(
                SearchTvSeriesSuccess(tvSeries: tvSeries),
              );
            } else {
              emit(
                SearchTvSeriesEmpty(),
              );
            }
          },
        );
      },
      transformer: (events, mapper) {
        final debonceStream = events.debounceTime(
          const Duration(milliseconds: 500),
        );
        final restartableTransformer =
            restartable<SearchTvSeriesOnQueryChanged>();
        return restartableTransformer(debonceStream, mapper);
      },
    );
  }
}
