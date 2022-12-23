import 'package:flutter/material.dart';
import 'package:tv_series_core/tv_series_core.dart';
import 'package:tv_series_detail/tv_series_detail.dart';

import '../component_library.dart';

class VerticaledTvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeriesList;

  const VerticaledTvSeriesList({
    Key? key,
    required this.tvSeriesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tvSeriesList.length,
      itemBuilder: (BuildContext context, int index) {
        final tvSeries = tvSeriesList[index];
        return TvSeriesCard(
          key: Key('tvSeries$index'),
          tvSeries: tvSeries,
          onTap: () {
            Navigator.pushNamed(
              context,
              TvSeriesDetailPage.routeName,
              arguments: tvSeries.id,
            );
          },
        );
      },
    );
  }
}
