import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';

class DrawerItemView extends StatelessWidget {
  const DrawerItemView({super.key, required this.onTap, required this.title});
  final Function()? onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: context.bodyLarge,
            ),
            const Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}
