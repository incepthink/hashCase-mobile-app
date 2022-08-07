import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../GlobalConstants.dart';
import '../../../GlobalWidgets/custom_snackbar.dart';
import '../../../services/api.dart';
import '../../Landing/landing.dart';

class SignInBuilder extends StatelessWidget {
  SignInBuilder({
    Key? key,
  }) : super(key: key);
  final _signInEmailController = TextEditingController();
  final _signInPasswordController = TextEditingController();
  final isLoadingEmail = ValueNotifier<bool>(false);
  final isLoadingMetamask = ValueNotifier<bool>(false);
  final loginShowPassword = ValueNotifier(false);

  _handleSingIn(context) async {
    isEmail(value) => RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    final String email = _signInEmailController.text;
    final String password = _signInPasswordController.text.trim();
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
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            width: double.infinity,
            // height: MediaQuery.of(context).size.height * 0.55,
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
                  'SIGN IN',
                  style: kTextStyleArcadeClassic.copyWith(
                      color: Colors.white, fontSize: 32),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
                          border: Border.all(width: 1.5, color: Colors.white54),
                        ),
                        child: TextFormField(
                          controller: _signInEmailController,
                          style: kTextStyleBody,
                          decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                fontSize: 16.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 17)),
                          cursorColor: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Column(
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
                      ValueListenableBuilder(
                          valueListenable: loginShowPassword,
                          builder: (context, bool show, child) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.5, color: Colors.white54),
                              ),
                              child: TextField(
                                onSubmitted: (_) async =>
                                    await _handleSingIn(context),
                                controller: _signInPasswordController,
                                obscureText: !show,
                                obscuringCharacter: '.',
                                style: kTextStyleBody.copyWith(
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.5),
                                decoration: InputDecoration(
                                  isDense: true,
                                  suffixIcon: InkWell(
                                    splashColor: Colors.white,
                                    onTap: () => loginShowPassword.value =
                                        !loginShowPassword.value,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: SvgPicture.asset(
                                        !show
                                            ? 'assets/icons/eye-closed.svg'
                                            : 'assets/icons/eye-open.svg',
                                        color: Colors.white,
                                        // height: 7,
                                      ),
                                    ),
                                  ),
                                  suffixIconConstraints: const BoxConstraints(),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                cursorColor: Colors.white70,
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 6),
                      InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
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
                        onTap: () async => await _handleSingIn(context),
                        child: Hero(
                          tag: 'third',
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 16),
                            padding: const EdgeInsets.symmetric(vertical: 16),
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
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 3,
                                            ),
                                          )
                                        : Text(
                                            'Sign In',
                                            style: kTextStyleH1.copyWith(
                                                fontSize: 16),
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
                          final ethMeta = await API.ethereumConnect();
                          API
                              .ethereumSign(
                            ethMeta,
                          )
                              .then(
                            (value) {
                              if (value) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const LandingPage(),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: kColorCta,
                                    content:
                                        Text('Failed to Sign-In with Metamask'),
                                  ),
                                );
                              }
                              isLoadingMetamask.value = false;
                            },
                          );
                        },
                        child: ValueListenableBuilder(
                            valueListenable: isLoadingMetamask,
                            builder: (context, bool value, child) {
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: kColorCta.withOpacity(0.2),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                ),
                                width: double.infinity,
                                child: value
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          SizedBox(
                                            height: 25,
                                            width: 25,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 3,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
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
                                        ],
                                      ),
                              );
                            }),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                              // showSingUpBottomSheet(context);
                            },
                            child: RichText(
                              text: TextSpan(
                                text: 'Don’t have an account?  ',
                                style: kTextStyleBody2,
                                children: [
                                  TextSpan(
                                    text: 'Sign up',
                                    style: kTextStyleBody2.copyWith(
                                      fontSize: 14,
                                      color: kColorCta,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
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
      ),
    );
  }
}
