import 'package:flutter/material.dart';
import 'package:movie_app/data/movie.dart';
import 'package:movie_app/data/tv_series.dart';
import 'package:movie_app/screens/tv_details_screen.dart';

import '../../common/image_cache_widget.dart';
import '../../screens/movie_details_screen.dart';

class MovieItem extends StatelessWidget {
  final Movie ? movie;
  final TvSeries ?tv;
  const MovieItem({super.key, this.movie, this.tv});

  @override
  Widget build(BuildContext context) {
    final String? title = movie?.title ?? tv?.name;
    final String? posterPath = movie?.posterPath ?? tv?.posterPath;
    final bool isMovie = movie != null;

    return InkWell(
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => isMovie
            ? MovieDetailsScreen(movie: movie!)
            : TvDetailsScreen(tv: tv!))
        )
      },
      child: SizedBox(
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: TmdbImage(
                  imagePath: posterPath ?? '',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title ?? 'Invalid title',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
