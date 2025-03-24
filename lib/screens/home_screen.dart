import 'package:flutter/material.dart';
import 'package:movie_app/components/home_carousel.dart';
import 'package:movie_app/components/trending_feature.dart';

import '../colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 36.0,
                  children: [
                    RichText(
                        text: TextSpan(
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold
                            ),
                            children: [
                              TextSpan(
                                  text: "Streaming  ",
                                  style: TextStyle(
                                      color: MColors.primary
                                  )
                              ),
                              TextSpan(
                                text: "EveryWhere",
                              )
                            ]
                        )
                    ),
                    HomeCarousel()
                  ]
              )
          ),
          TrendingFeature(),
        ],
      ),
      ),
    );
  }
}
