import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hash_case/GlobalConstants.dart';
import 'package:hash_case/pages/landing.dart';
import 'package:hash_case/services/api.dart';
import 'package:hash_case/services/smartContractFunctions.dart';
import 'package:hash_case/services/storageService.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../GlobalWidgets/animated_routing.dart';
import 'Onboarding/onboarding3.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _uri;
  late Timer timer;
  final _random = Random();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  int next(int min, int max) => min + _random.nextInt(max - min);
  double _fromY = 155;
  final _animationDuration = const Duration(milliseconds: 3000);
  final isLoading = ValueNotifier<bool>(false);
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

  Uri metamaskDownloadLink = Uri.parse("https://metamask.io/download/");
  Future<void> _launchUrl() async {
    if (!await launchUrl(
      metamaskDownloadLink,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $metamaskDownloadLink';
    }
  }

  var showPassword = false;
  _togglePasswordView() {
    print(showPassword);
    setState(() {
      showPassword = !showPassword;
    });
  }

  _ethereumConnect() async {
    try {
      final connector = WalletConnect(
        bridge: 'https://bridge.walletconnect.org',
        clientMeta: const PeerMeta(
          name: 'WalletConnect',
          description: 'WalletConnect Developer App',
          url: 'https://walletconnect.org',
          icons: [
            'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
          ],
        ),
      );
      if (!connector.connected) {
        final session = await connector.createSession(
            chainId: 4160,
            onDisplayUri: (uri) {
              _uri = uri;
              launchUrl(
                Uri.parse(uri),
              );
            });
      }

      // signTranaction
      final provider = EthereumWalletConnectProvider(connector);
      var ses = connector.session.accounts[0];
      await StorageService.JWTStorage.write(key: 'wallet_address', value: ses);
      launchUrl(
        Uri.parse(_uri),
      );
      final message = await API().getToken();
      final signedBytes = await provider.personalSign(
        message: message,
        address: ses,
        password: '',
      );
      //Getting the verified message

      final verifiedMessage = await API().getVerifiedToken(ses, signedBytes);
      if (verifiedMessage == "Token verified") {
        if (await API().metamaskLogin(ses)) {
          SmartContractFunction().smartContracts();
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LandingPage()));
        }
      }

      //kil session
      connector.killSession();
    } catch (e) {
      throw 'Could not launch $metamaskDownloadLink';
    }
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
                child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.99,
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
                  AnimatedPositioned(
                    curve: Curves.linear,
                    // left: 60,
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
                            image:
                                AssetImage("assets/vectors/login_avatar.png"),
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
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          child: BackdropFilter(
                            filter:
                                ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
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
                                        horizontal: 20),
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
                                            validator: (value) {
                                              isEmail(value) => RegExp(
                                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                  .hasMatch(value);

                                              if (value!.isEmpty) {
                                                return 'Enter Email or Phone linked to your account';
                                              }
                                              return !isEmail(value)
                                                  ? 'Enter a valid Email or Phone'
                                                  : null;
                                            },
                                            controller: _emailController,
                                            style: kTextStyleBody,
                                            decoration: InputDecoration(
                                                errorStyle: const TextStyle(
                                                  fontSize: 16.0,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
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
                                  const SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
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
                                            controller: _passwordController,
                                            obscureText: showPassword,
                                            obscuringCharacter: '.',
                                            style: kTextStyleBody.copyWith(
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: 1.5),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              // contentPadding:
                                              //     const EdgeInsets.symmetric(
                                              //         vertical: 15,
                                              //         horizontal: 5),
                                              // isCollapsed: true,
                                              suffixIcon: InkWell(
                                                onTap: () =>
                                                    _togglePasswordView(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
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
                                              // suffix: InkWell(
                                              //   onTap: () =>
                                              //       _togglePasswordView,
                                              //   child: SvgPicture.asset(
                                              //     showPassword
                                              //         ? 'assets/icons/eye-closed.svg'
                                              //         : 'assets/icons/eye-open.svg',
                                              //     color: Colors.white,
                                              //   ),
                                              // ),

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
                                          onTap: () async {
                                            final String email =
                                                _emailController.text;
                                            final String password =
                                                _passwordController.text.trim();
                                            final api = API();
                                            isLoading.value = true;
                                            bool result = await api.SignIN(
                                                email, password);
                                            isLoading.value = false;
                                            print('the result is $result');
                                            if (result) {
                                              print('test');
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LandingPage()),
                                              );
                                            } else {
                                              print('failed');
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  backgroundColor: kColorCta,
                                                  content:
                                                      Text('Error Logging in'),
                                                ),
                                              );
                                            }
                                          },
                                          child: Hero(
                                            tag: 'third',
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16),
                                              decoration: const BoxDecoration(
                                                color: kColorCta,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(4),
                                                ),
                                              ),
                                              width: double.infinity,
                                              child: ValueListenableBuilder(
                                                valueListenable: isLoading,
                                                builder: (context, box, value) {
                                                  return Material(
                                                    color: Colors.transparent,
                                                    child: Center(
                                                      child: isLoading.value
                                                          ? const SizedBox(
                                                              height: 25,
                                                              width: 25,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color: Colors
                                                                    .white,
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
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                backgroundColor: kColorCta,
                                                content: Text('In the works'),
                                              ),
                                            );
                                            // try {
                                            _ethereumConnect();
                                            // } catch (e) {
                                            //   print('===test===');
                                            //   await _launchUrl();
                                            // } finally {
                                            //   print('===test===');
                                            //   await _launchUrl();
                                            // }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            decoration: BoxDecoration(
                                              color: kColorCta.withOpacity(0.2),
                                              borderRadius:
                                                  const BorderRadius.all(
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
                                                    style: kTextStyleH1
                                                        .copyWith(fontSize: 16),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.symmetric(
                                        //       vertical: 8.0),
                                        //   child: Row(
                                        //     children: [
                                        //       Expanded(
                                        //         child: InkWell(
                                        //           onTap: () {
                                        //             ScaffoldMessenger.of(
                                        //                     context)
                                        //                 .showSnackBar(
                                        //               const SnackBar(
                                        //                 backgroundColor:
                                        //                     kColorCta,
                                        //                 content: Text(
                                        //                     'In the works'),
                                        //               ),
                                        //             );
                                        //           },
                                        //           child: Container(
                                        //             padding: const EdgeInsets
                                        //                 .symmetric(vertical: 8),
                                        //             decoration: BoxDecoration(
                                        //               color: kColorCta
                                        //                   .withOpacity(0.2),
                                        //               borderRadius:
                                        //                   const BorderRadius
                                        //                       .all(
                                        //                 Radius.circular(4),
                                        //               ),
                                        //             ),
                                        //             child: SvgPicture.asset(
                                        //               'assets/icons/apple-icon.svg',
                                        //               height: 35,
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       ),
                                        //       const SizedBox(
                                        //         width: 10,
                                        //       ),
                                        //       Expanded(
                                        //         child: InkWell(
                                        //           onTap: () {
                                        //             ScaffoldMessenger.of(
                                        //                     context)
                                        //                 .showSnackBar(
                                        //               const SnackBar(
                                        //                 backgroundColor:
                                        //                     kColorCta,
                                        //                 content: Text(
                                        //                     'In the works'),
                                        //               ),
                                        //             );
                                        //           },
                                        //           child: Container(
                                        //             padding: const EdgeInsets
                                        //                 .symmetric(vertical: 8),
                                        //             decoration: BoxDecoration(
                                        //               color: kColorCta
                                        //                   .withOpacity(0.2),
                                        //               borderRadius:
                                        //                   const BorderRadius
                                        //                       .all(
                                        //                 Radius.circular(4),
                                        //               ),
                                        //             ),
                                        //             child: SvgPicture.asset(
                                        //               'assets/icons/google-icon.svg',
                                        //               height: 35,
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text:
                                                    'Don’t have an account?  ',
                                                style: kTextStyleBody2,
                                                children: [
                                                  TextSpan(
                                                    text: 'Sign up',
                                                    style: kTextStyleBody2
                                                        .copyWith(
                                                            fontSize: 14,
                                                            color: kColorCta,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
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
            ))));
  }
}
