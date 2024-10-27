import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_company/theme_data/extensions/theme_ext.dart';


class CustomDropdown extends StatelessWidget {
  final String selectedValue;
  final ValueChanged<String?> onChanged;
  final List<String> dropdownItems;

  const CustomDropdown({
    super.key,
    required this.selectedValue,
    required this.onChanged,
    required this.dropdownItems,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      dropdownColor: context.bg2, // Assuming you have these extensions
      underline: SizedBox.shrink(),
      style: TextStyle(
        fontSize: context.bodyMedium.fontSize, // Using context for size
        color: context.textColor3,
      ),
      value: selectedValue,
      icon:
          Icon(CupertinoIcons.chevron_down, size: context.bodyMedium.fontSize),
      onChanged: onChanged,
      items: dropdownItems.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              item,
              style: TextStyle(
                fontSize: context.bodyMedium.fontSize,
                color: item == selectedValue
                    ? context.textColor1
                    : context.textColor2,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
