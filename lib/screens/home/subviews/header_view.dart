import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q_flow_company/reusable_components/alert/qr_alert.dart';
import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_company/theme_data/extensions/theme_ext.dart';

import '../../../extensions/img_ext.dart';
import '../../../mangers/alert_manger.dart';

class HeaderView extends StatelessWidget {
  const HeaderView({
    super.key,
    required this.companyName,
    required this.logoUrl,
    required this.interviewsCount,
    
  });

  final String companyName;
  final String? logoUrl;
  final int interviewsCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(
                Icons.menu,
                size: 30,
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(2),
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: logoUrl == null
                      ? const Image(image: Img.logoPurple, fit: BoxFit.cover)
                      : FadeInImage(
                          placeholder: Img.logoPurple,
                          image: NetworkImage(logoUrl!),
                          fit: BoxFit.cover,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image(
                                image: Img.logoPurple, fit: BoxFit.cover);
                          },
                        ),
                ),
              ),
            )),
            const SizedBox(width: 8),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 4),
                      Text(companyName,
                          style: context.bodyLarge, maxLines: 1, softWrap: true)
                    ],
                  ),
                  SizedBox(height: 4),
                   Row(
                  children: [
                    Icon(
                      CupertinoIcons.person_3_fill,
                      color: context.textColor3,
                      size: 21,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Total Applicants: ",
                      style: context.bodySmall,
                    ),
                    Text("$interviewsCount",
                        style: TextStyle(
                            fontSize: context.bodySmall.fontSize,
                            color: context.primary)),
                  ],
                ),
                ],
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () {
                  AlertManager().showQRAlert(
                    context: context,
                    title: companyName,
                    qr: Img.logo,
                  );
                },
                icon: const Icon(Icons.qr_code, size: 40),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
