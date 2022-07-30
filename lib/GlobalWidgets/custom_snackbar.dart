import 'package:flutter/material.dart';

import '../GlobalConstants.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();
showCustomSnackBar({
  required String text,
  Color color = kColorCta,
  EdgeInsets? margin,
}) {
  snackbarKey.currentState?.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: margin ?? const EdgeInsets.all(30),
      backgroundColor: color,
      content: Text(
        text,
        style: kTextStyleBody.copyWith(fontWeight: FontWeight.w600),
      ),
    ),
  );
}
