import 'package:flutter/material.dart';

import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_company/theme_data/extensions/theme_ext.dart';

class VisitorRatingBuild extends StatelessWidget {
  const VisitorRatingBuild({
    super.key,
    required this.title,
    required this.selectedRating,
    required this.setRating,
  });
  final String title;
  final int selectedRating;
  final Function(double) setRating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$title: ',
            style: TextStyle(
              fontSize: context.bodyMedium.fontSize,
              fontWeight: FontWeight.bold,
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              RatingStars(
                value: selectedRating.toDouble(),
                onValueChanged: (v) => setRating(v),
                starCount: 5,
                starSize: 22,
                maxValue: 5,
                starSpacing: 8,
                maxValueVisibility: true,
                valueLabelVisibility: false,
                animationDuration: const Duration(milliseconds: 500),
                valueLabelPadding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                valueLabelMargin: const EdgeInsets.only(right: 8),
                starOffColor: context.bg3,
                starColor: context.primary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
