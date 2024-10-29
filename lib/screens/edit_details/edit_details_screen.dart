import 'package:bootstrap_icons/bootstrap_icons.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_flow_company/model/enum/company_size.dart';
import 'package:q_flow_company/model/user/company.dart';
import 'package:q_flow_company/reusable_components/button/date_btn_view.dart';
import 'package:q_flow_company/reusable_components/custom_dropdown_view.dart';
import 'package:q_flow_company/reusable_components/dialog/error_dialog.dart';
import 'package:q_flow_company/reusable_components/dialog/loading_dialog.dart';
import 'package:q_flow_company/screens/edit_details/network_functions.dart';
import 'package:q_flow_company/supabase/supabase_mgr.dart';

import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_company/theme_data/extensions/theme_ext.dart';

import '../../extensions/img_ext.dart';
import '../../reusable_components/button/primary_btn.dart';
import '../../reusable_components/custom_text_field.dart';
import '../../reusable_components/page_header_view.dart';
import '../../utils/validations.dart';
import 'edit_details_cubit.dart';

class EditDetailsScreen extends StatelessWidget {
  const EditDetailsScreen(
      {super.key, this.company, this.isInitialSetup = true});
  final Company? company;
  final bool isInitialSetup;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditDetailsCubit(company),
      child: Builder(builder: (context) {
        final cubit = context.read<EditDetailsCubit>();

        return BlocListener<EditDetailsCubit, EditDetailsState>(
            listener: (context, state) async {
              if (cubit.previousState is LoadingState) {
                await Navigator.of(context).maybePop();
              }
              if (state is LoadingState &&
                  cubit.previousState is! LoadingState) {
                showLoadingDialog(context);
              }
              if (state is ErrorState) {
                showErrorDialog(context, state.msg);
              }
            },
            child: Scaffold(
              appBar: AppBar(),
              body: SafeArea(
                  child: Padding(
                padding: const EdgeInsets.all(24),
                child: ListView(
                  children: [
                    const PageHeaderView(title: 'Update Profile'),
                    Column(
                      children: [
                        BlocBuilder<EditDetailsCubit, EditDetailsState>(
                          builder: (context, state) {
                            return _ImgView(
                                logoImage: cubit.logoImage ?? Img.logo);
                          },
                        ),
                        TextButton(
                            onPressed: cubit.getImage,
                            child: Text('Add Logo',
                                style: TextStyle(
                                    fontSize: context.bodySmall.fontSize,
                                    color: context.primary,
                                    fontWeight:
                                        context.titleSmall.fontWeight))),
                        CustomTextField(
                            hintText: 'Company Name',
                            controller: cubit.nameController,
                            validation: Validations.name),
                        CustomTextField(
                          hintText: 'Description',
                          controller: cubit.descriptionController,
                          validation: Validations.name,
                          borderRadius: 40,
                          min: 4,
                          max: 6,
                        ),
                        Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            CustomTextField(
                                hintText: 'Company Size',
                                readOnly: true,
                                controller: TextEditingController(),
                                validation: Validations.none),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  BlocBuilder<EditDetailsCubit,
                                      EditDetailsState>(
                                    builder: (context, state) {
                                      return CustomDropdown(
                                        selectedValue: cubit.companySize.value,
                                        onChanged: (String? newValue) {
                                          if (newValue != null) {
                                            cubit.setSize(
                                                CompanySizeExtension.fromString(
                                                    newValue));
                                          }
                                        },
                                        dropdownItems: CompanySize.values
                                            .map((e) => e.value)
                                            .toList(),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            CustomTextField(
                                hintText: 'Established Year',
                                readOnly: true,
                                controller: TextEditingController(
                                    text: cubit.startDate.year.toString()),
                                validation: Validations.none),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  BlocBuilder<EditDetailsCubit,
                                      EditDetailsState>(
                                    builder: (context, state) {
                                      return DateBtnView(
                                          date: cubit.startDate,
                                          callback: (date) =>
                                              cubit.updateStartDate(date));
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        CustomTextField(
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(right: 32),
                              child: Icon(BootstrapIcons.linkedin),
                            ),
                            hintText: 'Linkedin',
                            controller: cubit.linkedInController,
                            validation: Validations.name),
                        CustomTextField(
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(right: 32),
                              child: Icon(BootstrapIcons.link_45deg),
                            ),
                            hintText: 'Website',
                            controller: cubit.websiteController,
                            validation: Validations.name),
                        CustomTextField(
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(right: 32),
                              child: Icon(BootstrapIcons.twitter_x),
                            ),
                            hintText: 'Twitter',
                            controller: cubit.xController,
                            validation: Validations.name),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: BlocBuilder<EditDetailsCubit,
                                  EditDetailsState>(
                                builder: (context, state) {
                                  return PrimaryBtn(
                                      callback: () => {
                                            if (isInitialSetup == false)
                                              {cubit.createNewCompany(context)}
                                            else
                                              {
                                                cubit.updateCompany(
                                                    context,
                                                    SupabaseMgr
                                                            .shared
                                                            .supabase
                                                            .auth
                                                            .currentUser
                                                            ?.id ??
                                                        '123')
                                              },
                                          },
                                      title: 'Next');
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )),
            ));
      }),
    );
  }
}

class _ImgView extends StatelessWidget {
  const _ImgView({
    required this.logoImage,
  });
  final ImageProvider logoImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipOval(
          child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              width: 140,
              height: 140,
              child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      elevation: 5,
                      child: ClipOval(
                        child: logoImage != null
                            ? Image(image: logoImage, fit: BoxFit.cover)
                            : const Image(image: Img.logo, fit: BoxFit.cover),
                      )))),
        ),
      ],
    );
  }
}
