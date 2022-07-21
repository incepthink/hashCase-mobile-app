import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hash_case/GlobalConstants.dart';
import 'package:hash_case/pages/landing.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Timer timer;
  final _random = Random();
  int next(int min, int max) => min + _random.nextInt(max - min);
  double _fromY = 155;
  final _animationDuration = const Duration(milliseconds: 3000);
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    int x = 0;
    timer = Timer.periodic(_animationDuration, (tick) {
      if (mounted)
        setState(() {
          _fromY = [140.0, 160.0][x];
        });
      x = 1 - x;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
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
          AnimatedPositioned(
            curve: Curves.linear,
            left: 60,
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
                    image: AssetImage("assets/vectors/login_avatar.png"),
                    // fit: BoxFit.cover,
                  ),
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
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 30, 25, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                ),
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.55,
                      decoration: const BoxDecoration(
                        color: Color(0x3300C2FF),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'SIGN IN',
                            style: kTextStyleArcadeClassic.copyWith(
                                color: Colors.white, fontSize: 32),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/email.svg',
                                      height: 14,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Email',
                                      style: kTextStyleBody2,
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.5, color: Colors.white54),
                                  ),
                                  child: TextField(
                                    style: kTextStyleBody,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    cursorColor: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/lock.svg',
                                      height: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Password',
                                      style: kTextStyleBody2,
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.5, color: Colors.white54),
                                  ),
                                  child: TextField(
                                    obscureText: true,
                                    obscuringCharacter: '.',
                                    style: kTextStyleBody.copyWith(
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1.5),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 5),
                                      // isCollapsed: true,
                                      suffix: InkWell(
                                        onTap: () {},
                                        child: Container(
                                          decoration: kDebugDecoration,
                                          child: SvgPicture.asset(
                                            true
                                                ? 'assets/icons/eye-closed.svg'
                                                : 'assets/icons/eye-open.svg',
                                          ),
                                        ),
                                      ),

                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    cursorColor: Colors.white70,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Forgot your password ?',
                                  style: kTextStyleBody2.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: kColorCta,
                                  ),
                                ),
                                InkWell(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LandingPage())),
                                  child: Hero(
                                    tag: 'third',
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      decoration: const BoxDecoration(
                                        color: kColorCta,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4),
                                        ),
                                      ),
                                      width: double.infinity,
                                      child: Center(
                                        child: Text(
                                          'Sign In',
                                          style: kTextStyleH1.copyWith(
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: kColorCta.withOpacity(0.2),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(4),
                                    ),
                                  ),
                                  width: double.infinity,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/metamask-icon.svg'),
                                        const SizedBox(width: 15),
                                        Text(
                                          'Continue with Metamask',
                                          style: kTextStyleH1.copyWith(
                                              fontSize: 16),
                                        ),
                                      ]),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          decoration: BoxDecoration(
                                            color: kColorCta.withOpacity(0.2),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(4),
                                            ),
                                          ),
                                          child: SvgPicture.asset(
                                            'assets/icons/apple-icon.svg',
                                            height: 35,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          decoration: BoxDecoration(
                                            color: kColorCta.withOpacity(0.2),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(4),
                                            ),
                                          ),
                                          child: SvgPicture.asset(
                                            'assets/icons/google-icon.svg',
                                            height: 35,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'Don’t have an account?  ',
                                        style: kTextStyleBody2,
                                        children: [
                                          TextSpan(
                                            text: 'Sign up',
                                            style: kTextStyleBody2.copyWith(
                                                fontSize: 14,
                                                color: kColorCta,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
