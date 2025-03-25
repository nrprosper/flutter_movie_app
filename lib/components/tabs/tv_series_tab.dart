import 'package:flutter/material.dart';
import 'package:movie_app/components/tabs/GridShimmer.dart';

import '../../data/tv_series.dart';
import '../../services/tmdb_service.dart';
import 'movie_item.dart';

class TvSeriesTab extends StatefulWidget {
  const TvSeriesTab({super.key});

  @override
  State<TvSeriesTab> createState() => _TvSeriesTabState();
}

class _TvSeriesTabState extends State<TvSeriesTab> {
  late final Future<List<TvSeries>> _tvSeriesFuture;

  @override
  void initState() {
    super.initState();
    _tvSeriesFuture = TmdbService().getTopRated().then((response) => response.results);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: FutureBuilder(
          future: _tvSeriesFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Error loading tv series: ${snapshot.error}'),
                ),
              );
            }
            return _buildSeries(snapshot);
          }
      ),
    );
  }
}


Widget _buildSeries(AsyncSnapshot<List<TvSeries>> snapshot) {
  if(!snapshot.hasData) {
    return Gridshimmer();
  }

  final series = snapshot.data!;
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.7,
      mainAxisSpacing: 24,
      crossAxisSpacing: 18,
    ),
    itemCount: series.length,
    itemBuilder: (context, index) => MovieItem(tv: series[index]),
  );

}

