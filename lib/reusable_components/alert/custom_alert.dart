import 'package:flutter/material.dart';
import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';

import '../button/primary_btn.dart';
import '../button/secondary_btn.dart';

class CustomAlert extends StatelessWidget {
  final String title;
  final String secondaryBtnText;
  final String primaryBtnText;
  final String message;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CustomAlert({
    super.key,
    required this.title,
    required this.secondaryBtnText,
    required this.primaryBtnText,
    required this.message,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(title,
            style: TextStyle(
                fontSize: context.titleSmall.fontSize,
                fontWeight: context.titleSmall.fontWeight)),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          message,
          style: context.bodyLarge,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: SecondaryBtn(
                      callback: onCancel, title: secondaryBtnText)),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: PrimaryBtn(callback: onConfirm, title: primaryBtnText),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
