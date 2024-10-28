import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q_flow_company/reusable_components/button/primary_btn.dart';
import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_company/theme_data/extensions/theme_ext.dart';

AwesomeDialog showErrorDialog(BuildContext context, String msg) {
  return AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      padding: EdgeInsets.all(24),
      dialogBorderRadius: BorderRadius.circular(24),
      dialogBackgroundColor: context.bg1,
      barrierColor: context.bg3.withOpacity(0.4),
      title: 'ERROR!',
      titleTextStyle: context.titleMedium,
      animType: AnimType.scale,
      desc: msg,
      descTextStyle: context.bodyMedium,
      btnOk:
          PrimaryBtn(callback: () => Navigator.of(context).pop(), title: 'OK'))
    ..show();
}
