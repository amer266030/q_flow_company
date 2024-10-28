import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q_flow_company/extensions/date_ext.dart';
import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_company/theme_data/extensions/theme_ext.dart';

class DateBtnView extends StatelessWidget {
  const DateBtnView({super.key, required this.date, required this.callback});
  final DateTime date;
  final ValueChanged<DateTime> callback;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return ElevatedButton(
      onPressed: () async {
        // Custom theme for the date picker
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(1970),
          lastDate: DateTime.now(),
          initialDatePickerMode: DatePickerMode.year,
          builder: (context, child) {
            ThemeData datePickerTheme;
            if (brightness == Brightness.light) {
              datePickerTheme = ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
                  primary: context.primary,
                  onPrimary: Colors.white,
                  onSurface: context.textColor1,
                ),
                dialogBackgroundColor: context.bg2,
              );
            } else {
              datePickerTheme = ThemeData.dark().copyWith(
                colorScheme: ColorScheme.dark(
                  primary: context.primary, // Customize the primary color
                  onPrimary:
                      context.textColor1, // Text color on primary background
                  onSurface: context.textColor2, // Text color on the picker
                ),
                dialogBackgroundColor:
                    context.bg2, // Background color for dark theme
              );
            }

            return Theme(
              data: datePickerTheme,
              child: child!,
            );
          },
        );

        if (pickedDate != null) {
          DateTime finalDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            date.hour,
            date.minute,
          );

          callback(finalDateTime);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(date.toFormattedString(), style: context.bodyMedium),
            const SizedBox(width: 16),
            Icon(
              CupertinoIcons.calendar,
              color: context.primary,
            ),
          ],
        ),
      ),
    );
  }
}
