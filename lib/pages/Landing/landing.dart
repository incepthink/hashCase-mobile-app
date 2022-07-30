import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hash_case/pages/Landing/profile/profile.dart';
import 'package:hash_case/pages/Onboarding/Onboarding1.dart';

import '../../GlobalConstants.dart';
import '../../services/api.dart';
import 'gallery/gallery.dart';
import 'my_nft/my_nft.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final currentIndex = ValueNotifier<int>(0);
  final pageController = PageController();
  _changePageIndex(newIndex) {
    pageController.animateToPage(newIndex,
        curve: Curves.ease, duration: const Duration(milliseconds: 600));
  }

  @override
  void initState() {
    super.initState();
    API.getCollections();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.white)),
      child: Scaffold(
        extendBody: true,
        backgroundColor: Color(0xff001217),
        bottomNavigationBar: ValueListenableBuilder(
            valueListenable: currentIndex,
            builder: (context, int value, child) {
              return ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.4), BlendMode.srcOver),
                    child: BottomNavigationBar(
                      backgroundColor: Colors.transparent,
                      selectedLabelStyle: kTextStyleSecondary.copyWith(
                          fontWeight: FontWeight.w600),
                      unselectedLabelStyle: kTextStyleSecondary,
                      unselectedItemColor: kColorGreySecondary,
                      selectedItemColor: Colors.white,
                      onTap: (index) => _changePageIndex(index),
                      currentIndex: currentIndex.value,
                      items: [
                        BottomNavigationBarItem(
                          icon: SvgPicture.asset(
                            'assets/icons/home.svg',
                            color: kColorGreySecondary,
                          ),
                          label: 'Home',
                          activeIcon: SvgPicture.asset(
                            'assets/icons/home.svg',
                            color: Colors.white,
                          ),
                        ),
                        BottomNavigationBarItem(
                          icon: SvgPicture.asset('assets/icons/wallet.svg'),
                          label: 'My NFTs',
                          activeIcon: SvgPicture.asset(
                            'assets/icons/wallet.svg',
                            color: Colors.white,
                          ),
                        ),
                        BottomNavigationBarItem(
                          icon: SvgPicture.asset('assets/icons/user.svg'),
                          label: 'Profile',
                          activeIcon: SvgPicture.asset(
                            'assets/icons/user.svg',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff082730), Color(0xff03161B)],
                ),
              ),
            ),
            PageView(
              controller: pageController,
              onPageChanged: (index) => currentIndex.value = index,
              physics: const BouncingScrollPhysics(),
              children: [
                const GalleryPage(),
                const MyNFTs(),
                ProfilePage(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
