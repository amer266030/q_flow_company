import 'package:flutter/material.dart';

import 'package:q_flow_company/theme_data/extensions/theme_ext.dart';

class CustomIconsSwitch extends StatelessWidget {
  final bool value;
  final IconData icon1;
  final IconData icon2;
  final ValueChanged<bool> onChanged;

  const CustomIconsSwitch({
    super.key,
    required this.value,
    required this.icon1,
    required this.icon2,
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
                    child: Icon(icon1,
                        color:
                            value ? context.textColor3 : Colors.transparent)),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(icon2,
                        color:
                            value ? Colors.transparent : context.textColor3)),
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
                    child: Icon(
                      !value ? icon1 : icon2,
                      color: Colors.white,
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
