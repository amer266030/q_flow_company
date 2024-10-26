import 'package:flutter/material.dart';
import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_company/theme_data/extensions/theme_ext.dart';

class ExpandedToggleButtons extends StatelessWidget {
  const ExpandedToggleButtons(
      {super.key,
      required this.currentIndex,
      required this.tabs,
      required this.callback});
  final int currentIndex;
  final List<String> tabs;
  final ValueChanged<int> callback;

  @override
  Widget build(BuildContext context) {
    List<bool> isSelected =
        List.generate(tabs.length, (index) => index == currentIndex);
    return Container(
      decoration: BoxDecoration(
        color: context.bg2,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: tabs
              .asMap() // Use asMap to get index along with value
              .map((index, str) => MapEntry(
                    index,
                    Expanded(
                      child: InkWell(
                        onTap: () => callback(index),
                        child: _ItemView(
                          str: str,
                          isSelected: isSelected[index],
                        ),
                      ),
                    ),
                  ))
              .values
              .toList(),
        ),
      ),
    );
  }
}

class _ItemView extends StatelessWidget {
  const _ItemView({required this.str, required this.isSelected});
  final String str;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.transparent,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(minWidth: double.infinity, minHeight: 25),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.transparent,
            gradient: LinearGradient(
              colors: [
                context.primary,
                context.primary.withOpacity(0.9),
                context.primary.withOpacity(0.7),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(minWidth: double.infinity, minHeight: 25),
              child: Center(
                child: Text(
                  str,
                  style: TextStyle(
                    fontSize: context.bodyMedium.fontSize,
                    color: isSelected ? Colors.white : context.textColor3,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
