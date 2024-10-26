import 'package:flutter/cupertino.dart';
import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_company/theme_data/extensions/theme_ext.dart';

import '../../model/user/visitor.dart';
import '../visitor_avatar.dart';

class VisitorAvatarControl extends StatelessWidget {
  const VisitorAvatarControl({
    required this.visitor,
    super.key,
  });
  final Visitor visitor;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          child: Column(
            children: [
              const AspectRatio(aspectRatio: 2, child: VisitorAvatar()),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(visitor.fName ?? '',
                      style: TextStyle(
                          fontSize: context.titleSmall.fontSize,
                          fontWeight: context.titleSmall.fontWeight),
                      maxLines: 1,
                      softWrap: true),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(visitor.lName ?? '',
                      style: TextStyle(
                          fontSize: context.titleSmall.fontSize,
                          fontWeight: context.titleSmall.fontWeight),
                      maxLines: 1,
                      softWrap: true),
                ],
              ),
              Text(visitor.id ?? '',
                  style: TextStyle(
                      fontSize: context.bodyLarge.fontSize,
                      color: context.textColor1),
                  maxLines: 3,
                  softWrap: true),
              Text('Front end developer',
                  style: TextStyle(
                      fontSize: context.bodyLarge.fontSize,
                      color: context.textColor1),
                  maxLines: 3,
                  softWrap: true),
            ],
          ),
        ));
  }
}
