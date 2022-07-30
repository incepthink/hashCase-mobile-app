import 'package:flutter/material.dart';

import '../GlobalConstants.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

showCustomSnackBar({
  required String text,
  Color color = kColorCta,
}) {
  snackbarKey.currentState?.showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(
        text,
        style: kTextStyleBody.copyWith(fontWeight: FontWeight.w600),
      ),
    ),
  );
}
