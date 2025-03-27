import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Recommendation<T> extends StatelessWidget {
  final Future<List<T>> future;
  final String title;
  final Widget Function(BuildContext, T) itemBuilder;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Axis scrollDirection;
  final EdgeInsetsGeometry padding;
  final double? listHeight;
  final TextStyle? titleStyle;
  final Widget? separator;

  const Recommendation({
    super.key,
    required this.future,
    required this.title,
    required this.itemBuilder,
    this.loadingWidget,
    this.errorWidget,
    this.scrollDirection = Axis.horizontal,
    this.padding = const EdgeInsets.symmetric(horizontal: 28.0),
    this.listHeight = 180,
    this.titleStyle,
    this.separator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding,
          child: Text(
            title,
            style: titleStyle ??
                const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        const SizedBox(height: 16),
        FutureBuilder<List<T>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return errorWidget ?? const SizedBox.shrink();
            }

            if (!snapshot.hasData) {
              return loadingWidget ?? _buildRecommendationShimmer();
            }

            final items = snapshot.data!;
            return SizedBox(
              height: listHeight,
              child: ListView.separated(
                padding: padding,
                scrollDirection: scrollDirection,
                itemCount: items.length,
                separatorBuilder: (_, __) =>
                separator ?? _buildDefaultSeparator(),
                itemBuilder: (_, index) => itemBuilder(context, items[index]),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDefaultSeparator() {
    return scrollDirection == Axis.horizontal
        ? const SizedBox(width: 16)
        : const SizedBox(height: 16);
  }
}


Widget _buildRecommendationShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.black12,
    highlightColor: Colors.grey,
    child: SizedBox(
      height: 180,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (_, index) => SizedBox(
          width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 120,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 100,
                height: 12,
                color: Colors.black26,
              ),
              const SizedBox(height: 4),
              Container(
                width: 80,
                height: 12,
                color: Colors.black26,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
