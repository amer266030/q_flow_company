import 'package:bootstrap_icons/bootstrap_icons.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_company/theme_data/extensions/theme_ext.dart';

import '../../extensions/img_ext.dart';
import '../../reusable_components/button/primary_btn.dart';
import '../../reusable_components/custom_text_field.dart';
import '../../reusable_components/page_header_view.dart';
import '../../utils/validations.dart';
import 'edit_details_cubit.dart';

class EditDetailsScreen extends StatelessWidget {
  const EditDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditDetailsCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<EditDetailsCubit>();
        return Scaffold(
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
                        return _ImgView(logoImage: cubit.logoImage ?? Img.logo);
                      },
                    ),
                    TextButton(
                        onPressed: cubit.getImage,
                        child: Text('Add Logo',
                            style: TextStyle(
                                fontSize: context.bodySmall.fontSize,
                                color: context.primary,
                                fontWeight: context.titleSmall.fontWeight))),
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
                          child: PrimaryBtn(
                              callback: () =>
                                  cubit.navigateToPositionOpening(context),
                              title: 'Next'),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )),
        );
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
