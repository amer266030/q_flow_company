
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerItemView extends StatelessWidget {
  const DrawerItemView({super.key, required this.onTap, required this.title});
  final Function()? onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(
        CupertinoIcons.circle,
      ),
      title: Text(
        title,
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: onTap,
    );
  }
}
