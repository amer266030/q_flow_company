import 'package:flutter/material.dart';
import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_company/theme_data/extensions/theme_ext.dart';

import '../../../extensions/img_ext.dart';
import '../../../mangers/alert_manger.dart';

class AppBarView extends StatelessWidget implements PreferredSizeWidget {
  const AppBarView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: const Icon(
            Icons.menu,
            size: 30,
          )),
      centerTitle: true,
      title: Text(
        "SDAIA",
        style: TextStyle(
          color: context.textColor1,
          fontSize: context.titleMedium.fontSize,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            AlertManager().showQRAlert(
                context: context, title: "Yara Albouq", qr: Img.logo);
          },
          icon: const Icon(Icons.qr_code, size: 40),
        ),
        const SizedBox(width: 24),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Divider(color: context.bg2),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
