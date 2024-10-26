import 'package:flutter/cupertino.dart';

import 'package:q_flow_company/theme_data/extensions/theme_ext.dart';

class VisitorAvatar extends StatelessWidget {
  const VisitorAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              context.primary,
              context.primary.withOpacity(0.9),
              context.primary.withOpacity(0.6),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: const [BoxShadow(blurRadius: 1)]),
      child: Icon(
        CupertinoIcons.person_solid,
        color: context.bg1,
        size: 35,
      ),
    );
  }
}
