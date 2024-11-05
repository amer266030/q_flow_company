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
  });

  final Company company;
  final Event event;

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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60.0, vertical: 8),
                  child: AspectRatio(
                      aspectRatio: 1,
                      child: Card(
                        elevation: 4,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: cubit.dataMgr.company?.logoUrl == null
                                ? const Image(
                                    image: Img.logoPurple, fit: BoxFit.cover)
                                : FadeInImage(
                                    placeholder: Img.logoPurple,
                                    image: NetworkImage(
                                        cubit.dataMgr.company!.logoUrl!),
                                    fit: BoxFit.cover,
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image(
                                          image: Img.logoPurple,
                                          fit: BoxFit.cover);
                                    },
                                  )),
                      )),
                ),
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
                Divider(
                  color: context.bg3,
                ),
                DrawerItemView(
                  onTap: () => cubit.navigateToEditDetails(context),
                  title: 'Update Details',
                ),
                SizedBox(
                  height: 4,
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
