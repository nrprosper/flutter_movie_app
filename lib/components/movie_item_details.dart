import 'package:flutter/material.dart';

import '../colors.dart';
import '../data/genre.dart';
import 'badge_pill.dart';

class MovieItemDetails extends StatelessWidget {
  final String title;
  final List<Genre> genres;
  final List<String> originCountry;
  final String releaseDate;
  final double voteAverage;
  final String ?overview;
  final bool isAdult;
  final bool isMovie;

  const MovieItemDetails({
    super.key,
    required this.title,
    required this.genres,
    required this.originCountry,
    required this.releaseDate,
    required this.voteAverage,
    this.overview,
    required this.isAdult,
    required this.isMovie,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600
                    ),
                  )),
              BadgePill(text: isAdult ? '18+' : '13+')
            ],
          ),
          SizedBox(height: 12.0),
          Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 18),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 0.2,
                          color: MColors.darkGrey
                      )
                  )
              ),
              child: Row(
                spacing: 32,
                children: [
                  Row(
                    spacing: 4,
                    children: [
                      Icon(Icons.access_time, size: 14),
                      Text(
                        "152 Minutes",
                        style: TextStyle(
                            color: MColors.grey,
                            fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ),
                  // SelectableText('${details.id}'),
                  Row(
                    spacing: 4,
                    children: [
                      Icon(Icons.star, size: 14),
                      Text(
                          '${voteAverage.toStringAsFixed(1)}/10',
                          style: TextStyle(
                              color: MColors.grey,
                              fontWeight: FontWeight.w600
                          )
                      )
                    ],
                  ),
                  Row(
                    spacing: 4,
                    children: [
                      Icon(Icons.flag, size: 14),
                      ...originCountry.map((country) => Text(
                        country,
                        style: TextStyle(
                            color: MColors.grey,
                            fontWeight: FontWeight.w600
                        ),
                      )),
                    ],
                  )
                ],
              )
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 18, 0, 18),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 0.5,
                        color: MColors.darkGrey
                    )
                )
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 32,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(
                        isMovie ? "Release Date" : 'First Air Date',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600
                        )
                    ),
                    Text(
                        '${releaseDate}'
                    )
                  ],
                ),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4,
                      children: [
                        Text(
                            "Genres",
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w600
                            )
                        ),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: genres.map((genre) {
                            return BadgePill(text: genre.name);
                          }).toList(),
                        ),
                      ],
                    )
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Synopsis",
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600
                    )
                ),
                SizedBox(height:12),
                Text(
                    overview ?? 'No Overview found',
                    style: TextStyle(
                        fontSize: 14,
                        color: MColors.grey,
                        fontWeight: FontWeight.w500
                    )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
