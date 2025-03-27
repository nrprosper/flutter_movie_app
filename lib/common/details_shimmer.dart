import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DetailsShimmer extends StatelessWidget {
  const DetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black12,
      highlightColor: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie Poster Shimmer
            Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 24),

            // Title Shimmer
            Container(
              width: 200,
              height: 28,
              color: Colors.black26,
            ),
            const SizedBox(height: 16),

            // Runtime and Rating Row
            Row(
              children: [
                Container(
                  width: 80,
                  height: 20,
                  color: Colors.black26,
                ),
                const SizedBox(width: 16),
                Container(
                  width: 100,
                  height: 20,
                  color: Colors.black26,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Release Date
            Container(
              width: 150,
              height: 18,
              color: Colors.black26,
            ),
            const SizedBox(height: 12),

            // Genres
            Wrap(
              spacing: 8,
              children: List.generate(2, (index) => Container(
                width: 60,
                height: 20,
                color: Colors.black26,
              )),
            ),
            const SizedBox(height: 24),

            // Synopsis Header
            Container(
              width: 80,
              height: 22,
              color: Colors.black26,
            ),
            const SizedBox(height: 12),

            // Synopsis Text Lines
            Column(
              children: List.generate(4, (index) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  width: double.infinity,
                  height: 16,
                  color: Colors.black26,
                ),
              )),
            ),
            const SizedBox(height: 24),

            // Related Movies Header
            Container(
              width: 120,
              height: 22,
              color: Colors.black26,
            ),
            const SizedBox(height: 16),

            // Related Movies List
            SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (_, index) => Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
