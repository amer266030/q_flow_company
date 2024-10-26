import 'package:flutter/material.dart';
import 'package:q_flow_company/theme_data/extensions/theme_ext.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final String option1;
  final String option2;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.option1,
    required this.option2,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: 90,
        height: 45,
        decoration: const BoxDecoration(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    option1,
                    style: TextStyle(
                      color: value ? context.textColor3 : Colors.transparent,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    option2,
                    style: TextStyle(
                      color: value ? Colors.transparent : context.textColor3,
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: 40,
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration:
                    const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        context.primary,
                        context.primary.withOpacity(0.8),
                        context.primary.withOpacity(0.4),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      !value ? option1 : option2,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
