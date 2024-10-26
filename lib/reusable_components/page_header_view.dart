import 'package:flutter/material.dart';

import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';

class PageHeaderView extends StatelessWidget {
  const PageHeaderView({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32, bottom: 48),
      child: Text(title, style: context.titleLarge),
    );
  }
}
