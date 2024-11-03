import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_flow_company/extensions/screen_size.dart';

import 'package:q_flow_company/screens/home/subviews/app_bar_view.dart';
import 'package:q_flow_company/screens/home/subviews/filter_item_view.dart';
import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_company/theme_data/extensions/theme_ext.dart';

import '../../model/enums/queue_status.dart';
import '../../model/enums/visitor_status.dart';
import '../../reusable_components/button/expanded_toggle_buttons.dart';
import '../../reusable_components/button/primary_btn.dart';
import '../../reusable_components/cards/swiper_card.dart';
import '../../reusable_components/cards/visitor_card.dart';
import '../../reusable_components/dialog/error_dialog.dart';
import '../../reusable_components/dialog/loading_dialog.dart';
import '../drawer/drawer_screen.dart';
import 'home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<HomeCubit>();
        return BlocListener<HomeCubit, HomeState>(
          listener: (context, state) {
            if (cubit.previousState is LoadingState) {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            }

            if (state is LoadingState) {
              showLoadingDialog(context);
            }

            if (state is ErrorState) {
              showErrorDialog(context, state.msg);
            }
          },
          child: Scaffold(
            appBar: AppBarView(
              companyName: cubit.dataMgr.company?.name ?? '',
            ),
            drawer: const DrawerScreen(),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            initiallyExpanded: true,
                            title: Text(
                              'Events',
                              style: TextStyle(
                                fontSize: context.bodyLarge.fontSize,
                                fontWeight: FontWeight.bold,
                                color: context.textColor1,
                              ),
                            ),
                            children: [
                              FilterItemView(
                                itemValues: cubit.events
                                    .map((e) => e.name ?? '')
                                    .toList(),
                                setValueFunc: (str) => cubit.selectEvent(str),
                                currentSelection:
                                    cubit.selectedEvent?.name ?? '',
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16, bottom: 16, left: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Queue Status',
                                  style: TextStyle(
                                    fontSize: context.bodyLarge.fontSize,
                                    fontWeight: FontWeight.bold,
                                    color: context.textColor1,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ExpandedToggleButtons(
                                    currentIndex: QueueStatus.values
                                        .indexOf(cubit.selectedQueueStatus),
                                    tabs: const ['Open', 'Close'],
                                    callback: (value) => cubit
                                        .toggleOpenApplying(context, value)),
                              ),
                            ],
                          ),
                        ),
                        ExpandedToggleButtons(
                          currentIndex: VisitorStatus.values
                              .indexOf(cubit.selectedVisitorStatus),
                          tabs:
                              VisitorStatus.values.map((c) => c.value).toList(),
                          callback: (int value) =>
                              cubit.setSelectedStatus(value),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: cubit.selectedVisitorStatus ==
                                  VisitorStatus.inQueue
                              ? Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: CarouselView(
                                    backgroundColor: Colors.transparent,
                                    itemExtent: context.screenWidth * 0.7,
                                    shrinkExtent: context.screenWidth * 0.7,
                                    scrollDirection: Axis.horizontal,
                                    children: cubit.filteredVisitors
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      int index =
                                          entry.key; // The index of the visitor
                                      var visitor =
                                          entry.value; // The visitor object

                                      return Column(
                                        children: [
                                          SwiperCard(visitor: visitor),
                                          const Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${index + 1} / ${cubit.filteredVisitors.length}',
                                                style: TextStyle(
                                                    fontSize: context
                                                        .titleSmall.fontSize,
                                                    color: context.primary),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  ))
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: cubit.filteredVisitors.length,
                                  itemBuilder: (context, index) {
                                    final visitor =
                                        cubit.filteredVisitors[index];
                                    return VisitorCard(
                                      visitor: visitor,
                                      isBookmarked:
                                          cubit.checkBookmark(visitor.id ?? ''),
                                      toggleBookmark: () =>
                                          cubit.toggleBookmark(
                                              context, visitor.id ?? ''),
                                    );
                                  },
                                ),
                        ),
                        cubit.selectedVisitorStatus == VisitorStatus.inQueue
                            ? Row(
                                children: [
                                  Expanded(
                                      child: PrimaryBtn(
                                          callback: () =>
                                              cubit.navigateToVisitorDetails(
                                                  context),
                                          title: "Start")),
                                ],
                              )
                            : const Text("")
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
