import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hash_case/pages/login.dart';

import '../../GlobalConstants.dart';
import '../../GlobalWidgets/animated_routing.dart';
import 'Onboarding2.dart';

class OnboardingPage3 extends StatefulWidget {
  const OnboardingPage3({Key? key}) : super(key: key);

  @override
  State<OnboardingPage3> createState() => _OnboardingPage3State();
}

class _OnboardingPage3State extends State<OnboardingPage3> {
  late Timer timer;
  late double _fromY;
  int x = 0;
  final _animationDuration = const Duration(milliseconds: 3000);
  @override
  void initState() {
    super.initState();
    final screenHeight = window.physicalSize.height / window.devicePixelRatio;
    _fromY = min(60, screenHeight * 0.15);
    startTimer();
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
    final size = MediaQuery.of(context).size;
    print(size.height);
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
                  // height: 186,
                  height: min(386, size.height * 0.25),
                  width: size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/onboarding_3.png"),
                      // fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              width: size.width * 0.95,
              bottom: 10,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 30, 25, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(14),
                      ),
                      child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 25),
                            decoration: const BoxDecoration(
                              color: Color(0x3300C2FF),
                              borderRadius: BorderRadius.all(
                                Radius.circular(14),
                              ),
                            ),
                            child: Row(
                              children: [
                                ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(minWidth: 80),
                                  child: Image.asset(
                                    'assets/images/cart.png',
                                    height: 60,
                                  ),
                                ),
                                const Expanded(
                                  child: Text(
                                    'Make customized nfts for your amazing products',
                                    style: kTextStyleH2,
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(minWidth: 80),
                            child: Image.asset(
                              'assets/images/database.png',
                              height: 40,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Expanded(
                            child: Text(
                              'Send it to your  community for them to claim their NFT!',
                              style: kTextStyleH2,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(minWidth: 80),
                            child: Image.asset(
                              'assets/images/email.png',
                              height: 40,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Expanded(
                            child: Text(
                              'Users claim their NFTs hassle free with email or wallet',
                              style: kTextStyleH2,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(minWidth: 80),
                            child: Image.asset(
                              'assets/images/confetti.png',
                              height: 40,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Expanded(
                            child: Text(
                              'Users get amazing utilities that come with the NFT!',
                              style: kTextStyleH2,
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          'How does it work',
                          style: kTextStyleH1,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      ktextOnboarding3,
                      style: kTextStyleBody,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Hero(
                          tag: 'second',
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
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
                                        const OnboardingPage2(),
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
                          tag: 'third',
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
                                        const LoginPage(),
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
