import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:q_flow_company/theme_data/extensions/theme_ext.dart';

AnimatedSnackBar animatedSnakbar({
  required String msg,
  required AnimatedSnackBarType type,
}) {
  return AnimatedSnackBar(
    animationDuration: Duration(milliseconds: 100),
    builder: ((context) {
      if (context.mounted) {
        return MaterialAnimatedSnackBar(
          messageText: msg,
          messageTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: context.bg1,
          ),
          type: type,
          foregroundColor: (type == AnimatedSnackBarType.info)
              ? context.primary
              : context.bg1,
          backgroundColor: (type == AnimatedSnackBarType.info)
              ? context.bg1
              : (type == AnimatedSnackBarType.success)
                  ? context.primary
                  : context.bg3,
          iconData: (type == AnimatedSnackBarType.info)
              ? CupertinoIcons.info_circle_fill
              : (type == AnimatedSnackBarType.success)
                  ? CupertinoIcons.check_mark_circled_solid
                  : CupertinoIcons.xmark_circle_fill,
        );
      } else {
        return const Text('');
      }
    }),
  );
}
