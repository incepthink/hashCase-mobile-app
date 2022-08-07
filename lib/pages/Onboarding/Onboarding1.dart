import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hash_case/pages/Onboarding/Onboarding2.dart';

import '../../GlobalConstants.dart';
import '../../GlobalWidgets/animated_routing.dart';

class OnboardingPage1 extends StatefulWidget {
  const OnboardingPage1({Key? key}) : super(key: key);

  @override
  State<OnboardingPage1> createState() => _OnboardingPage1State();
}

class _OnboardingPage1State extends State<OnboardingPage1> {
  double _fromY = 140;
  double initialHeight = 140;
  late Timer timer;
  final _animationDuration = const Duration(milliseconds: 3000);
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void startTimer() {
    int x = 0;
    timer = Timer.periodic(_animationDuration, (tick) {
      setState(() {
        _fromY = [initialHeight - 10, initialHeight + 10][x];
      });
      x = 1 - x;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    initialHeight = min(140, size.height * 0.15);
    return Scaffold(
      backgroundColor: const Color(0xff001217),
      body: SafeArea(
        top: false,
        child: Stack(
          alignment: Alignment.center,
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
            AnimatedPositioned(
              curve: Curves.linear,
              top: _fromY,
              duration: _animationDuration,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0), BlendMode.srcOver),
                child: Container(
                  height: min(486, size.height * 0.4),
                  width: 322,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/onboarding_1.png"),
                      // fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // height: 300,
              width: size.width * 0.95,
              bottom: 10,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 30, 25, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            text: 'NFT',
                            style: TextStyle(
                                fontFamily: 'GothamPro',
                                fontWeight: FontWeight.w700,
                                fontSize: 36),
                            children: [
                              TextSpan(
                                text: 'apparel',
                                style: TextStyle(
                                    fontFamily: 'GothamPro',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 36),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Adding  Real World  Utility   to  '
                                .toUpperCase(),
                            style: const TextStyle(
                                fontFamily: 'ArcadeClassic',
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                            children: const [
                              TextSpan(
                                text: 'NFTs',
                                style: TextStyle(
                                    fontFamily: 'ArcadeClassic',
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff00C2FF),
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      bodyText,
                      style: kTextStyleBody,
                    ),
                    const SizedBox(height: 15),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: const BoxDecoration(
                        color: kColorCta,
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      // width: double.infinity,
                      child: Center(
                        child: InkWell(
                          onTap: () => Navigator.of(context).pushReplacement(
                            animatedRoute(
                                const OnboardingPage2(),
                                RouteType.RIGHT_TO_LEFT,
                                const Duration(milliseconds: 700)),
                          ),
                          child: Text(
                            'Explore Now',
                            style: kTextStyleH1.copyWith(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
