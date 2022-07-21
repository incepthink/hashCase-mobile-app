import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hash_case/pages/login.dart';

import '../../GlobalConstants.dart';
import '../../GlobalWidgets/animated_routing.dart';
import 'Onboarding1.dart';
import 'Onboarding2.dart';

class OnboardingPage3 extends StatefulWidget {
  const OnboardingPage3({Key? key}) : super(key: key);

  @override
  State<OnboardingPage3> createState() => _OnboardingPage3State();
}

class _OnboardingPage3State extends State<OnboardingPage3> {
  double _fromY = 60;
  late Timer timer;
  int x = 0;
  final _animationDuration = const Duration(milliseconds: 3000);
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    int x = 0;
    timer = Timer.periodic(_animationDuration, (tick) {
      setState(() {
        _fromY = [50.0, 70.0][x];
      });
      x = 1 - x;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              left: 60,
              top: _fromY,
              duration: _animationDuration,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0), BlendMode.srcOver),
                child: Container(
                  height: 286,
                  width: 322,
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
              height: 620,
              width: size.width * 0.95,
              bottom: 40,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 30, 25, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
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
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Hero(
                          tag: 'second',
                          child: Material(
                            color: Colors.transparent,
                            child: ClipRRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 20.0, sigmaY: 20.0),
                                child: Container(
                                  // width: 70,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 16),
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
                                      onTap: () => Navigator.of(context).push(
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
                          ),
                        ),
                        Hero(
                          tag: 'third',
                          child: Material(
                            color: Colors.transparent,
                            child: ClipRRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 20.0, sigmaY: 20.0),
                                child: Container(
                                  // width: 70,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 15, 20, 15),
                                  decoration: const BoxDecoration(
                                    color: Color(0x3300C2FF),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4),
                                    ),
                                  ),
                                  // width: double.infinity,
                                  child: Center(
                                    child: InkWell(
                                      onTap: () => Navigator.of(context).push(
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
