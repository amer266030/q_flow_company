import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_company/theme_data/extensions/theme_ext.dart';

class OpenApplyingView extends StatelessWidget {
  const OpenApplyingView({
    super.key,
    required this.onOpen,
    required this.value,
  });

  final Function(bool)? onOpen;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'OpenApplying',
            style: TextStyle(
              fontSize: context.bodyLarge.fontSize,
              fontWeight: FontWeight.bold,
              color: context.textColor1,
            ),
          ).tr(),
        ],
      ),
    );
  }
}
