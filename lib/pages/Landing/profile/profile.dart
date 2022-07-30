import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hash_case/GlobalWidgets/custom_snackbar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../GlobalConstants.dart';
import '../../../HiveDB/UserData/UserData.dart';
import '../../../services/api.dart';
import '../../Onboarding/Onboarding1.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final showPassword = ValueNotifier<bool>(false);
  final showConfirmPassword = ValueNotifier<bool>(false);
  final isLoading = ValueNotifier<bool>(false);
  _togglePasswordView(int x) {
    if (x == 0) {
      showPassword.value = !showPassword.value;
    } else {
      showConfirmPassword.value = !showConfirmPassword.value;
    }
  }

  _handleConnect() async {
    final email = emailController.text;
    final password = passwordController.text;
    print(email);
    print(password);
    final Result result = await API.connectEmail(email, password);
    result.when(
      (error) => showCustomSnackBar(
        text: error.toString(),
      ),
      (success) {
        showCustomSnackBar(text: "Email Connected");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 100),
                  child: Text(
                    'MY PROFILE',
                    style: kTextStyleGotham,
                  ),
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 15),
                      height: 130,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFF03556E),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            'Member since 20 August 2021',
                            style: kTextStyleBody,
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: -80,
                      child: Image.asset(
                        'assets/images/user.png',
                        height: 160,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ValueListenableBuilder(
                    valueListenable:
                        Hive.box('globalBox').listenable(keys: ['userData']),
                    builder: (context, Box<dynamic> box, child) {
                      final UserData userData = box.get('userData');
                      if (userData.email != '-') {
                        return Container(
                          margin: EdgeInsets.only(bottom: 20),
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Color(0xFF03556E),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Email Address',
                                style: kTextStyleBody2,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                userData.email,
                                style: kTextStyleBody,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    }),
                ValueListenableBuilder(
                  valueListenable:
                      Hive.box('globalBox').listenable(keys: ['userData']),
                  builder: (context, Box box, child) {
                    UserData userData = box.get('userData');
                    if (userData.walletAddress != '-') {
                      return Container(
                        margin: EdgeInsets.only(bottom: 20),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Color(0xFF03556E),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Wallet Address',
                              style: kTextStyleBody2,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              userData.walletAddress!,
                              style: kTextStyleBody,
                            )
                          ],
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
            Column(
              children: [
                ValueListenableBuilder(
                  valueListenable:
                      Hive.box('globalBox').listenable(keys: ['userData']),
                  builder: (context, Box box, child) {
                    UserData userData = box.get('userData');
                    if (userData.walletAddress == '-') {
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          color: kColorCta,
                        ),
                        child: Text(
                          'Connect Wallet',
                          style: kTextStyleBody.copyWith(
                              fontWeight: FontWeight.w600),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                ValueListenableBuilder(
                    valueListenable:
                        Hive.box('globalBox').listenable(keys: ['userData']),
                    builder: (context, Box box, child) {
                      UserData userData = box.get('userData');
                      if (userData.email == '-') {
                        return InkWell(
                          onTap: () {
                            showModalBottomSheet(
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
                                return Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: ClipRRect(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 20.0, sigmaY: 20.0),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 20),
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                          color: Color(0x3300C2FF),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Connect',
                                              style: kTextStyleArcadeClassic
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 32),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 20),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                          color:
                                                              Colors.white54),
                                                    ),
                                                    child: TextFormField(
                                                      controller:
                                                          emailController,
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
                                                      // controller: _emailController,
                                                      style: kTextStyleBody,
                                                      decoration:
                                                          InputDecoration(
                                                              errorStyle:
                                                                  const TextStyle(
                                                                fontSize: 16.0,
                                                              ),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15.0),
                                                                borderSide:
                                                                    BorderSide
                                                                        .none,
                                                              ),
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          17)),
                                                      cursorColor:
                                                          Colors.white70,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 20),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                  ValueListenableBuilder(
                                                      valueListenable:
                                                          showPassword,
                                                      builder: (context,
                                                          bool show, child) {
                                                        return Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                width: 1.5,
                                                                color: Colors
                                                                    .white54),
                                                          ),
                                                          child: TextField(
                                                            controller:
                                                                passwordController,
                                                            obscureText: !show,
                                                            obscuringCharacter:
                                                                '.',
                                                            style: kTextStyleBody
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    letterSpacing:
                                                                        1.5),
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              suffixIcon:
                                                                  InkWell(
                                                                splashColor:
                                                                    Colors
                                                                        .white,
                                                                onTap: () =>
                                                                    _togglePasswordView(
                                                                        0),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          8.0),
                                                                  child:
                                                                      SvgPicture
                                                                          .asset(
                                                                    !show
                                                                        ? 'assets/icons/eye-open.svg'
                                                                        : 'assets/icons/eye-closed.svg',
                                                                    color: Colors
                                                                        .white,
                                                                    // height: 7,
                                                                  ),
                                                                ),
                                                              ),
                                                              suffixIconConstraints:
                                                                  const BoxConstraints(),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15.0),
                                                                borderSide:
                                                                    BorderSide
                                                                        .none,
                                                              ),
                                                            ),
                                                            cursorColor:
                                                                Colors.white70,
                                                          ),
                                                        );
                                                      }),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 20),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/lock.svg',
                                                        height: 16,
                                                      ),
                                                      const SizedBox(width: 8),
                                                      const Text(
                                                        'Confirm Password',
                                                        style: kTextStyleBody2,
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  ValueListenableBuilder(
                                                      valueListenable:
                                                          showConfirmPassword,
                                                      builder: (context,
                                                          bool show, child) {
                                                        return Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                width: 1.5,
                                                                color: Colors
                                                                    .white54),
                                                          ),
                                                          child: TextField(
                                                            onSubmitted:
                                                                (_) async {
                                                              await _handleConnect();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            controller:
                                                                confirmPasswordController,
                                                            obscureText: !show,
                                                            obscuringCharacter:
                                                                '.',
                                                            style: kTextStyleBody
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    letterSpacing:
                                                                        1.5),
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              suffixIcon:
                                                                  InkWell(
                                                                splashColor:
                                                                    Colors
                                                                        .white,
                                                                onTap: () =>
                                                                    _togglePasswordView(
                                                                        1),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          8.0),
                                                                  child:
                                                                      SvgPicture
                                                                          .asset(
                                                                    !show
                                                                        ? 'assets/icons/eye-open.svg'
                                                                        : 'assets/icons/eye-closed.svg',
                                                                    color: Colors
                                                                        .white,
                                                                    // height: 7,
                                                                  ),
                                                                ),
                                                              ),
                                                              suffixIconConstraints:
                                                                  const BoxConstraints(),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15.0),
                                                                borderSide:
                                                                    BorderSide
                                                                        .none,
                                                              ),
                                                            ),
                                                            cursorColor:
                                                                Colors.white70,
                                                          ),
                                                        );
                                                      }),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  const SizedBox(height: 6),
                                                  InkWell(
                                                    onTap: () async {
                                                      await _handleConnect();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child:
                                                        ValueListenableBuilder(
                                                            valueListenable:
                                                                isLoading,
                                                            builder: (context,
                                                                bool value,
                                                                child) {
                                                              if (value) {
                                                                return const SizedBox(
                                                                  height: 25,
                                                                  width: 25,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: Colors
                                                                        .white,
                                                                    strokeWidth:
                                                                        3,
                                                                  ),
                                                                );
                                                              }
                                                              return Container(
                                                                margin: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        16),
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        16),
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  color:
                                                                      kColorCta,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            4),
                                                                  ),
                                                                ),
                                                                width: double
                                                                    .infinity,
                                                                child: Material(
                                                                  color: Colors
                                                                      .transparent,
                                                                  child: Center(
                                                                    child: Text(
                                                                      'Connect',
                                                                      style: kTextStyleH1.copyWith(
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                  ),
                                                  const SizedBox(height: 20),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              color: kColorCta,
                            ),
                            child: Text(
                              'Connect Email ',
                              style: kTextStyleBody.copyWith(
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    }),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const OnboardingPage1(),
                      ),
                    );
                    API.signOut;
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                      color: kColorDanger,
                    ),
                    child: Text(
                      'Sign Out',
                      style:
                          kTextStyleBody.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
