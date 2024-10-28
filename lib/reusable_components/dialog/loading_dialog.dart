import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:q_flow_company/extensions/img_ext.dart';
import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_company/theme_data/extensions/theme_ext.dart';

AwesomeDialog showLoadingDialog(BuildContext context) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    padding: EdgeInsets.all(24),
    dialogBorderRadius: BorderRadius.circular(24),
    dialogBackgroundColor: context.bg1,
    barrierColor: context.bg3.withOpacity(0.4),
    dismissOnTouchOutside: false,
    animType: AnimType.scale,
    body: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: AspectRatio(
            aspectRatio: 1,
            child: Image(image: Img.logo, fit: BoxFit.contain),
          ),
        ),
        SizedBox(height: 16),
        Text('Please wait...', style: context.bodyMedium),
      ],
    ),
  )..show();
}
