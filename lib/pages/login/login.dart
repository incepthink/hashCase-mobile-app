import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hash_case/GlobalConstants.dart';
import 'package:hash_case/pages/Landing/landing.dart';
import 'package:hash_case/services/api.dart';
import '../../GlobalWidgets/animated_routing.dart';
import '../../GlobalWidgets/custom_snackbar.dart';
import '../Onboarding/onboarding3.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Timer timer;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _animationDuration = const Duration(milliseconds: 3000);
  final isLoadingEmail = ValueNotifier<bool>(false);
  final isLoadingMetamask = ValueNotifier<bool>(false);
  double _fromY = 155;
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    int x = 0;
    timer = Timer.periodic(_animationDuration, (tick) {
      if (mounted) {
        setState(() {
          _fromY = [140.0, 160.0][x];
        });
      }
      x = 1 - x;
    });
  }

  var showPassword = false;
  _togglePasswordView() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  _handleSingIn() async {
    isEmail(value) => RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    final String email = _emailController.text;
    final String password = _passwordController.text.trim();
    if (email.isEmpty || !isEmail(email)) {
      showCustomSnackBar(
        text: "Please enter a valid email",
        color: kColorDanger,
      );
      return;
    }
    if (password.length < 2) {
      showCustomSnackBar(
        text: "Please enter a password",
        color: kColorDanger,
      );
      return;
    }
    isLoadingEmail.value = true;
    final result = await API.signIn(email, password);
    result.when(
      (exception) => showCustomSnackBar(
        text: exception.toString().substring(10),
        color: kColorDanger,
      ),
      (value) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const LandingPage()),
      ),
    );
    isLoadingEmail.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: WillPopScope(
        onWillPop: () {
          Navigator.of(context).pushReplacement(animatedRoute(
              const OnboardingPage3(),
              RouteType.LEFT_TO_RIGHT,
              const Duration(milliseconds: 700)));
          return Future.value(true);
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                BackgroundWrapper(),
                AvatarBuilder(
                    fromY: _fromY, animationDuration: _animationDuration),
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
                      Header(),
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
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
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 20),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                              width: 1.5,
                                              color: Colors.white54),
                                        ),
                                        child: TextFormField(
                                          controller: _emailController,
                                          style: kTextStyleBody,
                                          decoration: InputDecoration(
                                              errorStyle: const TextStyle(
                                                fontSize: 16.0,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                borderSide: BorderSide.none,
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 17)),
                                          cursorColor: Colors.white70,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 20),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                              width: 1.5,
                                              color: Colors.white54),
                                        ),
                                        child: TextField(
                                          onSubmitted: (_) => _handleSingIn(),
                                          controller: _passwordController,
                                          obscureText: !showPassword,
                                          obscuringCharacter: '.',
                                          style: kTextStyleBody.copyWith(
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 1.5),
                                          decoration: InputDecoration(
                                            isDense: true,
                                            suffixIcon: InkWell(
                                              splashColor: Colors.white,
                                              onTap: () =>
                                                  _togglePasswordView(),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: SvgPicture.asset(
                                                  showPassword
                                                      ? 'assets/icons/eye-closed.svg'
                                                      : 'assets/icons/eye-open.svg',
                                                  color: Colors.white,
                                                  // height: 7,
                                                ),
                                              ),
                                            ),
                                            suffixIconConstraints:
                                                const BoxConstraints(),
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
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const SizedBox(height: 6),
                                      InkWell(
                                        onTap: () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              backgroundColor: kColorCta,
                                              content: Text('In the works'),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Forgot your password ?',
                                          style: kTextStyleBody2.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: kColorCta,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: _handleSingIn,
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
                                            child: ValueListenableBuilder(
                                              valueListenable: isLoadingEmail,
                                              builder: (context, box, value) {
                                                return Material(
                                                  color: Colors.transparent,
                                                  child: Center(
                                                    child: isLoadingEmail.value
                                                        ? const SizedBox(
                                                            height: 25,
                                                            width: 25,
                                                            child:
                                                                CircularProgressIndicator(
                                                              color:
                                                                  Colors.white,
                                                              strokeWidth: 3,
                                                            ),
                                                          )
                                                        : Text(
                                                            'Sign In',
                                                            style: kTextStyleH1
                                                                .copyWith(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          isLoadingMetamask.value = true;
                                          final ethMeta =
                                              await API.ethereumConnect();
                                          API
                                              .ethereumSign(
                                            ethMeta,
                                          )
                                              .then(
                                            (value) {
                                              if (value) {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LandingPage(),
                                                  ),
                                                );
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    backgroundColor: kColorCta,
                                                    content: Text(
                                                        'Failed to Sign-In with Metamask'),
                                                  ),
                                                );
                                              }
                                              isLoadingMetamask.value = false;
                                            },
                                          );
                                        },
                                        child: ValueListenableBuilder(
                                            valueListenable: isLoadingMetamask,
                                            builder:
                                                (context, bool value, child) {
                                              return Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12),
                                                decoration: BoxDecoration(
                                                  color: kColorCta
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(4),
                                                  ),
                                                ),
                                                width: double.infinity,
                                                child: value
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: const [
                                                          SizedBox(
                                                            height: 25,
                                                            width: 25,
                                                            child:
                                                                CircularProgressIndicator(
                                                              color:
                                                                  Colors.white,
                                                              strokeWidth: 3,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SvgPicture.asset(
                                                              'assets/icons/metamask-icon.svg'),
                                                          const SizedBox(
                                                              width: 15),
                                                          Text(
                                                            'Continue with Metamask',
                                                            style: kTextStyleH1
                                                                .copyWith(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                        ],
                                                      ),
                                              );
                                            }),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: 'Don’t have an account?  ',
                                              style: kTextStyleBody2,
                                              children: [
                                                TextSpan(
                                                  text: 'Sign up',
                                                  style:
                                                      kTextStyleBody2.copyWith(
                                                    fontSize: 14,
                                                    color: kColorCta,
                                                    fontWeight: FontWeight.w700,
                                                  ),
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
          ),
        ),
      ),
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
    return AnimatedPositioned(
      curve: Curves.linear,
      // left: 60,
      top: _fromY,
      duration: _animationDuration,
      child: ColorFiltered(
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0), BlendMode.srcOver),
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
    );
  }
}

class BackgroundWrapper extends StatelessWidget {
  const BackgroundWrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0), BlendMode.srcOver),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
