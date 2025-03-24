import 'package:flutter/material.dart';
import 'package:movie_app/colors.dart';

import '../components/tabs_feature.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  children: [
                    Text(
                      "Find Movies, Tv series, and more...",
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 30),
                    SearchBar(
                      leading: Icon(Icons.search),
                      hintText: "Sherlock Holmes",
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      hintStyle: WidgetStatePropertyAll(
                        TextStyle(
                            color: MColors.searchTextColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16.0)),
                      shadowColor: WidgetStatePropertyAll(Colors.transparent)
                    ),
                    const SizedBox(height: 30),
                    TabsFeature()
                  ],
                )
            ),
        )
    );
  }
}
