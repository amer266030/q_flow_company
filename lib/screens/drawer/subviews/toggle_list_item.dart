import 'package:flutter/cupertino.dart';
import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_company/theme_data/extensions/theme_ext.dart';

import '../../../reusable_components/button/custom_icons_switch.dart';
import '../../../reusable_components/button/custom_switch.dart';

class ToggleListItem extends StatelessWidget {
  const ToggleListItem({
    super.key,
    required this.title,
    required this.value,
    required this.callback,
    this.strItems,
    this.iconItems,
  });
  final String title;
  final bool value;
  final List<String>? strItems;
  final List<IconData>? iconItems;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                const SizedBox(width: 8),
                Text(
                  title,
                  style: context.bodyLarge,
                ),
              ],
            ),
          ),
          if (strItems != null)
            CustomSwitch(
                value: value,
                option1: strItems![0],
                option2: strItems![1],
                onChanged: (_) => callback())
          else
            CustomIconsSwitch(
                value: value,
                icon1: iconItems![0],
                icon2: iconItems![1],
                onChanged: (_) => callback())
        ],
      ),
    );
  }
}
