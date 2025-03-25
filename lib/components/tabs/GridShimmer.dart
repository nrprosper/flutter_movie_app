import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Gridshimmer extends StatelessWidget {
  const Gridshimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black12,
      highlightColor: Colors.grey,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemCount: 6,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(8),
                    )),
                const SizedBox(height: 8),
                Container(
                  height: 16,
                  width: 100,
                  color: Colors.black26,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                ),
                const SizedBox(height: 4),
                Container(
                  height: 14,
                  width: 80,
                  color: Colors.black26,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                ),
              ]
          ),
        ),
      ),
    );
  }
}
