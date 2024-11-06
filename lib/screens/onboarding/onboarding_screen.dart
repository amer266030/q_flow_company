import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';

import '../../reusable_components/button/primary_btn.dart';
import '../../reusable_components/dialog/error_dialog.dart';
import '../../reusable_components/dialog/loading_dialog.dart';
import 'onboarding_cubit.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(context),
      child: Builder(builder: (context) {
        final cubit = context.read<OnboardingCubit>();
        return BlocListener<OnboardingCubit, OnboardingState>(
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
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: BlocBuilder<OnboardingCubit, OnboardingState>(
                    builder: (context, state) {
                      return Image(
                          image: cubit.images[cubit.idx], fit: BoxFit.fill);
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                  child: BlocBuilder<OnboardingCubit, OnboardingState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cubit.content[cubit.idx].$1,
                              style: context.titleMedium),
                          const SizedBox(height: 16),
                          Text(cubit.content[cubit.idx].$2,
                              style: context.bodyMedium),
                          const SizedBox(height: 24),
                          if (cubit.idx == 2)
                            Row(
                              children: [
                                Expanded(
                                  child: PrimaryBtn(
                                      callback: () =>
                                          cubit.navigateToAuth(context),
                                      title: 'Login'.tr()),
                                ),
                              ],
                            )
                          else
                            Row(
                              children: [
                                Expanded(
                                  child: PrimaryBtn(
                                      callback: cubit.changeIdx, title: 'Next'.tr()),
                                ),
                              ],
                            )
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
