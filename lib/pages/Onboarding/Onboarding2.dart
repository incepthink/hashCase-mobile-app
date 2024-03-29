import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../GlobalConstants.dart';
import '../../GlobalWidgets/animated_routing.dart';
import 'Onboarding1.dart';
import 'onboarding3.dart';

class OnboardingPage2 extends StatefulWidget {
  const OnboardingPage2({Key? key}) : super(key: key);

  @override
  State<OnboardingPage2> createState() => _OnboardingPage2State();
}

class _OnboardingPage2State extends State<OnboardingPage2> {
  double _fromY = 90;
  late Timer timer;
  int x = 0;
  final _animationDuration = const Duration(milliseconds: 3000);
  @override
  void initState() {
    super.initState();
    startTimer();
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
        _fromY = [_fromY - 10, _fromY + 10][x];
      });
      x = 1 - x;
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    print('Onboarding2');

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        top: false,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0), BlendMode.srcOver),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/background.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.srcOver),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.2),
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
                  height: 486,
                  width: 322,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/onboarding_2.png"),
                      // fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // height: 265,
              width: size.width * 0.95,
              bottom: 10,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 30, 25, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: const [
                        Text(
                          'How are we Helping Brands',
                          style: kTextStyleH1,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      bodyText.split('').reversed.join(),
                      style: kTextStyleBody,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Hero(
                          tag: 'first',
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              // width: 70,
                              margin: const EdgeInsets.symmetric(vertical: 16),
                              padding:
                                  const EdgeInsets.fromLTRB(20, 15, 50, 15),
                              decoration: const BoxDecoration(
                                color: Color(0x3300C2FF),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                              ),
                              // width: double.infinity,
                              child: Center(
                                child: InkWell(
                                  onTap: () =>
                                      Navigator.of(context).pushReplacement(
                                    animatedRoute(
                                        const OnboardingPage1(),
                                        RouteType.LEFT_TO_RIGHT,
                                        const Duration(milliseconds: 700)),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/icons/arrow_left_round.svg',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Hero(
                          tag: 'second',
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 16),
                              padding:
                                  const EdgeInsets.fromLTRB(50, 15, 20, 15),
                              decoration: const BoxDecoration(
                                color: kColorCta,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                              ),
                              // width: double.infinity,
                              child: Center(
                                child: InkWell(
                                  onTap: () =>
                                      Navigator.of(context).pushReplacement(
                                    animatedRoute(
                                        const OnboardingPage3(),
                                        RouteType.RIGHT_TO_LEFT,
                                        const Duration(milliseconds: 700)),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/icons/arrow_right_round.svg',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
