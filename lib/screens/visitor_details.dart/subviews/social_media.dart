import 'package:bootstrap_icons/bootstrap_icons.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_company/theme_data/extensions/theme_ext.dart';

import '../visitor_details_cubit.dart';

class SocialMediaView extends StatelessWidget {
  const SocialMediaView({
    super.key,
    required this.cubit,
  });

  final VisitorDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () => cubit.launchCall('tel:+1234567890'),
              icon: Icon(
                CupertinoIcons.phone_fill,
                color: context.primary,
              )),
          IconButton(
              onPressed: () => cubit.launchEmail('test@gmail.com'),
              icon: Icon(
                Icons.mail,
                color: context.primary,
              )),
          IconButton(
              onPressed: () => cubit.launchLink('https://pub.dev'),
              icon: Icon(
                CupertinoIcons.link,
                color: context.primary,
              )),
          IconButton(
              onPressed: () => cubit.launchLink('https://pub.dev'),
              icon: Icon(
                BootstrapIcons.linkedin,
                color: context.primary,
                size: context.titleSmall.fontSize,
              )),
          IconButton(
              onPressed: () => cubit.launchLink('https://pub.dev'),
              icon: Icon(
                BootstrapIcons.twitter_x,
                color: context.primary,
                size: context.titleSmall.fontSize,
              )),
        ],
      ),
    );
  }
}
