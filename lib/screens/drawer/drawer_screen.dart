import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_flow_company/screens/drawer/network_functions.dart';
import 'package:q_flow_company/screens/drawer/subviews/drawer_item_view.dart';
import 'package:q_flow_company/screens/drawer/subviews/toggle_list_item.dart';
import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_company/theme_data/extensions/theme_ext.dart';

import '../../extensions/img_ext.dart';
import '../../model/event/event.dart';
import '../../model/user/company.dart';
import 'drawer_cubit.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({
    super.key,
    required this.company,
    required this.event,
    required this.interviewsCount,
  });

  final Company company;
  final Event event;
  final int interviewsCount;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DrawerCubit(context),
      child: Builder(builder: (context) {
        final cubit = context.read<DrawerCubit>();
        return Drawer(
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                AspectRatio(
                  aspectRatio: 2,
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 65),
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
                      child: cubit.dataMgr.company?.logoUrl == null
                          ? const Image(image: Img.logo, fit: BoxFit.contain)
                          : ClipOval(
                              child: Image.network(
                                cubit.dataMgr.company!.logoUrl!,
                                fit: BoxFit.cover,
                              ),
                            )),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.center,
                  child: Text(cubit.dataMgr.company?.name ?? '',
                      style: TextStyle(
                          fontSize: context.titleMedium.fontSize,
                          fontWeight: context.titleLarge.fontWeight)),
                ),
                const SizedBox(height: 16),
                Text(event.name ?? '',
                    style: context.bodyLarge, maxLines: 1, softWrap: true),
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
                      "${event.startDate} - ${event.endDate}",
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
                    Text("$interviewsCount",
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
                BlocBuilder<DrawerCubit, DrawerState>(
                  builder: (context, state) {
                    return ToggleListItem(
                        title: 'Language',
                        value: cubit.isEnglish,
                        strItems: const ['AR', 'EN'],
                        callback: () => cubit.toggleLanguage(context));
                  },
                ),
                BlocBuilder<DrawerCubit, DrawerState>(
                  builder: (context, state) {
                    return ToggleListItem(
                        title: 'Theme Mode',
                        value: cubit.isDarkMode,
                        iconItems: const [
                          CupertinoIcons.sun_max,
                          CupertinoIcons.moon
                        ],
                        callback: () => cubit.toggleDarkMode(context));
                  },
                ),
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
