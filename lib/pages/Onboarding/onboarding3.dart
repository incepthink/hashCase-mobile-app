import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hash_case/pages/login/login.dart';

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
  double _fromY = 140;
  double initialHeight = 140;
  final _animationDuration = const Duration(milliseconds: 3000);
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    int x = 0;
    timer = Timer.periodic(_animationDuration, (tick) {
      setState(() {
        _fromY = [initialHeight - 10, initialHeight + 10][x];
        print('fromY = $_fromY');
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
    initialHeight = min(140, size.height * 0.15);
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
                padding: const EdgeInsets.symmetric(horizontal: 25),
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
                              horizontal: 8, vertical: 20),
                          decoration: const BoxDecoration(
                            color: Color(0x3300C2FF),
                            borderRadius: BorderRadius.all(
                              Radius.circular(13),
                            ),
                          ),
                          child: Row(
                            children: [
                              ConstrainedBox(
                                constraints: const BoxConstraints(minWidth: 70),
                                child: Image.asset(
                                  'assets/images/cart.png',
                                  height: 48,
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
                        ),
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => DescriptionCard(
                        description: Description.descriptions[index],
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemCount: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 35, vertical: 10),
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
                              child: const Text(
                                'Back',
                                style: kTextStyleH2,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 35, vertical: 10),
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
                              child: const Text(
                                'Next',
                                style: kTextStyleH2,
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

class DescriptionCard extends StatelessWidget {
  const DescriptionCard({
    required this.description,
    Key? key,
  }) : super(key: key);
  final Description description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 60),
            child: Image.asset(
              description.imagePath,
              height: 36,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              description.text,
              style: kTextStyleBody.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Description {
  String text;
  String imagePath;
  Description({
    required this.text,
    required this.imagePath,
  });
  static List<Description> descriptions = [
    Description(
      text: "Send it to your  community for them to claim their NFT!",
      imagePath: 'assets/images/database.png',
    ),
    Description(
      text: "Users claim their NFTs hassle free with email or wallet",
      imagePath: 'assets/images/email.png',
    ),
    Description(
      text: "Users get amazing utilities that come with the NFT!",
      imagePath: 'assets/images/confetti.png',
    )
  ];
}
