import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_company/theme_data/extensions/theme_ext.dart';

class StarRatingView extends StatelessWidget {
  const StarRatingView({
    super.key,
    required this.title,
    required this.text,
    required this.selectedRating,
    required this.setRating,
  });
  final String title;
  final String text;
  final int selectedRating;
  final Function(double) setRating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: '$title: ',
                    style: TextStyle(
                      fontSize: context.bodyMedium.fontSize,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            softWrap: true,
          ),
        ),
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
                animationDuration: Duration(milliseconds: 500),
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
