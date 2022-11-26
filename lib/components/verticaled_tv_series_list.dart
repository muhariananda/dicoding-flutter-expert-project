import 'package:ditonton/components/components.dart';
import 'package:ditonton/core/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/feature/tv_series/page/tv_series_detail_page.dart';
import 'package:flutter/material.dart';

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
              TvSeriesDetailPage.ROUTE_NAME,
              arguments: tvSeries.id,
            );
          },
        );
      },
    );
  }
}
