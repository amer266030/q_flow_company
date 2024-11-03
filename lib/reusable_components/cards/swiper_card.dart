import 'package:flutter/cupertino.dart';
import 'package:q_flow_company/extensions/screen_size.dart';
import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';

import '../../extensions/img_ext.dart';
import '../../model/user/visitor.dart';
import '../../model/enums/bootcamp.dart';
import '../visitor_avatar.dart';

class SwiperCard extends StatelessWidget {
  const SwiperCard({
    required this.visitor,
    super.key,
  });
  final Visitor visitor;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: context.screenWidth * 0.5,
              height: context.screenWidth * 0.5,
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipOval(
                  child: visitor.avatarUrl == null
                      ? const VisitorAvatar()
                      : FadeInImage(
                          placeholder: Img.logoPurple,
                          image: NetworkImage(visitor.avatarUrl!),
                          fit: BoxFit.contain,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return const Image(
                                image: Img.avatar, fit: BoxFit.cover);
                          },
                        ),
                ),
              ),
            ),
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
                    style: context.titleSmall, maxLines: 1, softWrap: true),
              ],
            ),
            Text(visitor.id?.substring(0, 13) ?? '',
                style: context.bodyMedium, maxLines: 3, softWrap: true),
            Text(visitor.bootcamp?.value ?? '',
                style: context.bodyMedium, maxLines: 3, softWrap: true),
          ],
        ));
  }
}
