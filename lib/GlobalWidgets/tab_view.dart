import 'package:flutter/material.dart';

import '../../GlobalConstants.dart';

class TabView extends StatelessWidget {
  final TabController tabController;
  final List<String> tabs;
  final List<String>? icons;
  final bool showGradient;
  final Color indicatorColor;
  final double barHeight;
  final double fontSize;

  const TabView({
    Key? key,
    required this.tabController,
    required this.tabs,
    this.showGradient = true,
    this.indicatorColor = kColorGreySecondary,
    this.barHeight = 70,
    this.fontSize = 18,
    this.icons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: barHeight,
          decoration: const BoxDecoration(),
          child: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Align(
              alignment: Alignment.center,
              child: TabBar(
                padding: const EdgeInsets.only(left: 5),
                isScrollable: true,
                controller: tabController,
                indicatorColor: indicatorColor,
                labelColor: Colors.white,
                unselectedLabelColor: kColorGreySecondary,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: returnTabs(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> returnTabs() {
    return tabs
        .map(
          (tabTitle) => Tab(
            height: 40,
            child: Text(
              tabTitle,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: fontSize,
                fontFamily: 'DMSans',
              ),
            ),
          ),
        )
        .toList();
  }
}
