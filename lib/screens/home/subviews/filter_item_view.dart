import 'package:flutter/material.dart';
import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_company/theme_data/extensions/theme_ext.dart';

class FilterItemView extends StatelessWidget {
  const FilterItemView({
    super.key,
    required this.itemValues,
    this.currentSelection,
    required this.setValueFunc,
  });

  final List<String> itemValues;
  final String? currentSelection;
  final Function(String) setValueFunc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: itemValues
                          .map((value) => InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () => setValueFunc(value),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: context.bg2,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                            color: (currentSelection == value)
                                                ? context.primary
                                                : context.bg3)),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 8),
                                        child: Text(value,
                                            style: TextStyle(
                                                fontSize:
                                                    context.bodySmall.fontSize,
                                                color:
                                                    (currentSelection == value)
                                                        ? context.textColor1
                                                        : context.textColor2))),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
