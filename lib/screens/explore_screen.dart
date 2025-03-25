import 'package:flutter/material.dart';
import 'package:movie_app/colors.dart';
import 'package:movie_app/components/tabs/movies_tab.dart';
import 'package:movie_app/components/tabs/tv_series_tab.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SafeArea(
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
                    DefaultTabController(
                        length: 4,
                        child: Column(
                          children: [
                            TabBar(
                              indicatorWeight: 1,
                              indicatorSize: TabBarIndicatorSize.label,
                              dividerColor: MColors.darkGrey,
                              dividerHeight: 0.6,
                              isScrollable: true,
                              labelPadding: EdgeInsets.only(right: 40),
                              tabAlignment: TabAlignment.start,
                              labelStyle: TextStyle(
                                color: MColors.primary,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600
                              ),
                              indicatorColor: Colors.transparent,
                              overlayColor: WidgetStatePropertyAll(Colors.transparent),
                              tabs: [
                                Tab(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Movies"),
                                  ),
                                ),
                                Tab(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Tv Series"),
                                  ),
                                ),
                                Tab(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Documentary"),
                                  ),
                                ),
                                Tab(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("Sports"),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 900,
                              child: TabBarView(children: [
                                MoviesTab(),
                                TvSeriesTab(),
                                Text("Documentary"),
                                Text("Sports"),
                              ]),
                            )
                          ],
                        )
                    )
                  ],
                )
            ),
        )
    );
  }
}
