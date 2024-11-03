import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_company/theme_data/extensions/theme_ext.dart';

import '../../extensions/img_ext.dart';
import '../../model/user/visitor.dart';
import '../button/book_mark_btn.dart';
import '../visitor_avatar.dart';
import '../../model/enums/bootcamp.dart';

class VisitorCard extends StatelessWidget {
  const VisitorCard({
    super.key,
    required this.visitor,
    required this.toggleBookmark,
    required this.isBookmarked,
  });
  final Visitor visitor;
  final bool isBookmarked;
  final VoidCallback toggleBookmark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        decoration: BoxDecoration(
            color: context.bg2,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: context.textColor1.withOpacity(0.3),
                  blurRadius: 4,
                  spreadRadius: 0.5,
                  offset: const Offset(3, 3))
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: ClipOval(
                            child: visitor.avatarUrl == null
                                ? const VisitorAvatar()
                                : FadeInImage(
                                    placeholder: Img.logoPurple,
                                    image: NetworkImage(visitor.avatarUrl!),
                                    fit: BoxFit.contain,
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return const Image(
                                          image: Img.avatar, fit: BoxFit.cover);
                                    },
                                  ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(visitor.fName ?? '',
                                    style: context.bodyMedium,
                                    maxLines: 1,
                                    softWrap: true),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(visitor.lName ?? '',
                                    style: context.bodyMedium,
                                    maxLines: 1,
                                    softWrap: true),
                              ],
                            ),
                            Text(visitor.id?.substring(0, 13) ?? '',
                                style: context.bodySmall,
                                maxLines: 3,
                                softWrap: true),
                            Text(visitor.bootcamp?.value ?? '',
                                style: context.bodySmall,
                                maxLines: 3,
                                softWrap: true),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              BookMarkbtn(
                  isBookmarked: isBookmarked, toggleBookmark: toggleBookmark)
            ],
          ),
        ),
      ),
    );
  }
}
