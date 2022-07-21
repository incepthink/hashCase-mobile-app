import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hash_case/pages/Gallery.dart';

import '../GlobalConstants.dart';
import 'mynft.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int currentIndex = 0;
  final pageController = PageController();
  _changePageIndex(newIndex) {
    setState(() {
      currentIndex = newIndex;
      pageController.animateToPage(newIndex,
          curve: Curves.ease, duration: const Duration(milliseconds: 200));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.white)),
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.black,
        bottomNavigationBar: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.srcOver),
              child: BottomNavigationBar(
                onTap: (index) => _changePageIndex(index),
                currentIndex: currentIndex,
                items: [
                  BottomNavigationBarItem(
                      backgroundColor: Colors.transparent,
                      icon: SvgPicture.asset(
                        'assets/icons/home.svg',
                        color: kColorGreySecondary,
                      ),
                      label: 'Home',
                      activeIcon: SvgPicture.asset(
                        'assets/icons/home.svg',
                        color: Colors.white,
                      )),
                  BottomNavigationBarItem(
                      backgroundColor: Colors.transparent,
                      icon: SvgPicture.asset('assets/icons/wallet.svg'),
                      label: 'My NFTs',
                      activeIcon: SvgPicture.asset('assets/icons/wallet.svg',
                          color: Colors.white)),
                  BottomNavigationBarItem(
                      icon:
                          SvgPicture.asset('assets/icons/bookmark_outline.svg'),
                      label: 'Saved',
                      activeIcon: SvgPicture.asset(
                          'assets/icons/bookmark_outline.svg',
                          color: Colors.white)),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/icons/user.svg'),
                    label: 'Profile',
                    activeIcon: SvgPicture.asset('assets/icons/user.svg',
                        color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0), BlendMode.srcOver),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/vectors/background.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            PageView(
              controller: pageController,
              onPageChanged: (index) => _changePageIndex(index),
              physics: const BouncingScrollPhysics(),
              children: [
                GalleryPage(),
                const MyNFTs(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}