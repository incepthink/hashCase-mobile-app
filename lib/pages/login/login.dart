import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hash_case/GlobalConstants.dart';
import 'package:hash_case/pages/login/widgets/sign_in_builder.dart';
import 'package:hash_case/pages/login/widgets/sign_up_builder.dart';
import '../../GlobalWidgets/animated_routing.dart';
import '../Onboarding/onboarding3.dart';
import 'dart:math';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Timer timer;
  late double initialHeight;
  final _animationDuration = const Duration(milliseconds: 3000);

  double _fromY = 155;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  void startTimer() {
    int x = 0;
    timer = Timer.periodic(_animationDuration, (tick) {
      if (mounted) {
        setState(() {
          _fromY = [initialHeight - 10, initialHeight + 10][x];
        });
      }
      x = 1 - x;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    initialHeight = min(120, size.height * 0.15);
    return Scaffold(
      backgroundColor: const Color(0xff001217),
      body: WillPopScope(
        onWillPop: () {
          Navigator.of(context).pushReplacement(animatedRoute(
              const OnboardingPage3(),
              RouteType.LEFT_TO_RIGHT,
              const Duration(milliseconds: 700)));
          return Future.value(true);
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const BackgroundWrapper(),
              AvatarBuilder(
                  fromY: _fromY, animationDuration: _animationDuration),
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Header(),
                    Column(
                      children: [
                        InkWell(
                          onTap: () => showSignInBottomSheet(context),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 50),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                gradient: kGradientG1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Sign In',
                                  style: kTextStyleH2,
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => showSingUpBottomSheet(context),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 50),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              color: const Color(0x3300C2FF),
                              borderRadius: BorderRadius.circular(4),
                              // gradient: kGradientG1,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Sign Up',
                                  style: kTextStyleH2,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.05),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showSingUpBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return SignUpBuilder();
      },
    );
  }

  showSignInBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SignInBuilder();
      },
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 30, 25, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: const TextSpan(
              text: 'INCEPTHINK',
              style: TextStyle(
                  fontFamily: 'GothamPro',
                  fontWeight: FontWeight.w700,
                  fontSize: 36),
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Adding  Real World  Utility   to  '.toUpperCase(),
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
    );
  }
}

class AvatarBuilder extends StatelessWidget {
  const AvatarBuilder({
    Key? key,
    required double fromY,
    required Duration animationDuration,
  })  : _fromY = fromY,
        _animationDuration = animationDuration,
        super(key: key);

  final double _fromY;
  final Duration _animationDuration;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedPositioned(
      curve: Curves.linear,
      // left: 60,
      top: _fromY,
      duration: _animationDuration,
      child: ColorFiltered(
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0), BlendMode.srcOver),
        child: Container(
          height: min(486, size.height * 0.5),
          width: 322,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/vectors/login_avatar.png"),
              // fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class BackgroundWrapper extends StatelessWidget {
  const BackgroundWrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff082730), Color(0xff03161B)],
        ),
      ),
    );
  }
}
