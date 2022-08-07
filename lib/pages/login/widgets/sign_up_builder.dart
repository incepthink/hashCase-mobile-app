import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../GlobalConstants.dart';
import '../../../GlobalWidgets/custom_snackbar.dart';
import '../../../services/api.dart';
import '../../Landing/landing.dart';

class SignUpBuilder extends StatelessWidget {
  SignUpBuilder({
    Key? key,
  }) : super(key: key);
  final _signUpEmailController = TextEditingController();
  final _signUpPasswordController = TextEditingController();
  final _signUpConfirmPasswordController = TextEditingController();
  final isLoadingSignUp = ValueNotifier<bool>(false);
  final signUpShowPassword = ValueNotifier(false);
  final signUpShowConfirmPassword = ValueNotifier(false);
  _handleSignUp(context) async {
    isEmail(value) => RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    final String email = _signUpEmailController.text;
    final String password = _signUpPasswordController.text.trim();
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
    isLoadingSignUp.value = true;
    final result = await API.signUp(email, password);
    result.when(
      (exception) => showCustomSnackBar(
        text: exception.toString().substring(10),
        color: kColorDanger,
      ),
      (value) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const LandingPage()),
      ),
    );
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
                  'Sign Up',
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
                          controller: _signUpEmailController,
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
                          valueListenable: signUpShowPassword,
                          builder: (context, bool show, child) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.5, color: Colors.white54),
                              ),
                              child: TextField(
                                controller: _signUpPasswordController,
                                obscureText: !show,
                                obscuringCharacter: '.',
                                style: kTextStyleBody.copyWith(
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.5),
                                decoration: InputDecoration(
                                  isDense: true,
                                  suffixIcon: InkWell(
                                    splashColor: Colors.white,
                                    onTap: () => signUpShowPassword.value =
                                        !signUpShowPassword.value,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: SvgPicture.asset(
                                        !show
                                            ? 'assets/icons/eye-open.svg'
                                            : 'assets/icons/eye-closed.svg',
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
                            'Confirm Password',
                            style: kTextStyleBody2,
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      ValueListenableBuilder(
                          valueListenable: signUpShowConfirmPassword,
                          builder: (context, bool show, child) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.5, color: Colors.white54),
                              ),
                              child: TextField(
                                onSubmitted: (_) async =>
                                    await _handleSignUp(context),
                                controller: _signUpConfirmPasswordController,
                                obscureText: !show,
                                obscuringCharacter: '.',
                                style: kTextStyleBody.copyWith(
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.5),
                                decoration: InputDecoration(
                                  isDense: true,
                                  suffixIcon: InkWell(
                                    splashColor: Colors.white,
                                    onTap: () =>
                                        signUpShowConfirmPassword.value =
                                            !signUpShowConfirmPassword.value,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: SvgPicture.asset(
                                        !show
                                            ? 'assets/icons/eye-open.svg'
                                            : 'assets/icons/eye-closed.svg',
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
                        onTap: () async => await _handleSignUp(context),
                        child: ValueListenableBuilder(
                          valueListenable: isLoadingSignUp,
                          builder: (context, bool value, child) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 16),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: const BoxDecoration(
                                color: kColorCta,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                              ),
                              width: double.infinity,
                              child: Material(
                                color: Colors.transparent,
                                child: Center(
                                  child: value
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 3,
                                          ),
                                        )
                                      : Text(
                                          'Sign Up',
                                          style: kTextStyleH1.copyWith(
                                              fontSize: 16),
                                        ),
                                ),
                              ),
                            );
                          },
                        ),
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
  }
}
