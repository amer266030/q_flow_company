import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_flow_company/screens/drawer/subviews/drawer_item_view.dart';
import 'package:q_flow_company/screens/drawer/subviews/toggle_list_item.dart';
import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_company/theme_data/extensions/theme_ext.dart';

import '../../extensions/img_ext.dart';
import 'drawer_cubit.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocProvider(
      create: (context) => DrawerCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<DrawerCubit>();
        return Drawer(
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                AspectRatio(
                    aspectRatio: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 8,
                              blurStyle: BlurStyle.outer),
                        ],
                      ),
                      child: const Image(image: Img.logo),
                    )),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.center,
                  child: Text(cubit.dataMgr.company?.name ?? '',
                      style: TextStyle(
                          fontSize: context.titleMedium.fontSize,
                          fontWeight: context.titleLarge.fontWeight)),
                ),
                const SizedBox(height: 16),
                Text(
                  "Job Fair 123",
                  style: context.bodyLarge,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.calendar,
                      color: context.textColor3,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "01/01/2024 - 03/01/2024",
                      style: context.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
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
                    Text("200",
                        style: TextStyle(
                            fontSize: context.bodySmall.fontSize,
                            color: context.primary)),
                  ],
                ),
                Divider(
                  color: context.bg3,
                ),
                DrawerItemView(
                  onTap: () => cubit.navigateToEditDetails(context),
                  title: 'Update Details',
                ),
                DrawerItemView(
                  onTap: () => cubit.navigateToPrivacyPolicy(context),
                  title: 'Privacy Policy',
                ),
                ToggleListItem(
                    title: 'Language',
                    value: cubit.isEnglish,
                    strItems: const ['AR', 'EN'],
                    callback: () => cubit.toggleLanguage(context)),
                ToggleListItem(
                    title: 'Theme Mode',
                    value: cubit.isDarkMode,
                    iconItems: const [
                      CupertinoIcons.sun_max,
                      CupertinoIcons.moon
                    ],
                    callback: () => cubit.toggleDarkMode(context)),
                DrawerItemView(
                    title: 'Logout', onTap: () => cubit.logout(context)),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class DrawerToggleItem extends StatelessWidget {
  const DrawerToggleItem({
    super.key,
    required this.title,
    required this.value,
    required this.callback,
  });
  final String title;
  final bool value;
  final VoidCallback callback;

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
        trailing: Switch(value: value, onChanged: (_) => callback()));
  }
}
