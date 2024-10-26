import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_flow_company/extensions/screen_size.dart';
import 'package:q_flow_company/model/enum/tech_skill.dart';
import 'package:q_flow_company/screens/visitor_details.dart/subviews/social_media.dart';
import 'package:q_flow_company/screens/visitor_details.dart/visitor_details_cubit.dart';
import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_company/theme_data/extensions/theme_ext.dart';

import '../../extensions/img_ext.dart';
import '../../mangers/alert_manger.dart';
import '../../model/enum/visitor_rating.dart';
import '../../reusable_components/button/book_mark_btn.dart';
import '../../reusable_components/button/primary_btn.dart';
import '../../reusable_components/button/secondary_btn.dart';
import '../../reusable_components/custom_text_field.dart';
import '../../reusable_components/visitor_avatar.dart';
import '../../reusable_components/visitor_rating_build.dart';
import '../../utils/validations.dart';

class VisitorDetailsScreen extends StatelessWidget {
  const VisitorDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VisitorDetailsCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<VisitorDetailsCubit>();
        return Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: BookMarkbtn(isBookmarked: false, toggleBookmark: () {}),
              )
            ],
          ),
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                BlocBuilder<VisitorDetailsCubit, VisitorDetailsState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                width: context.screenWidth * 0.19,
                                height: context.screenHeight * 0.1,
                                child: const VisitorAvatar()),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Yara Albouq",
                                    style: TextStyle(
                                        fontSize: context.titleSmall.fontSize,
                                        fontWeight:
                                            context.titleMedium.fontWeight)),
                                Text(
                                  "123456",
                                  style: context.bodyLarge,
                                ),
                              ],
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                  onPressed: () {
                                    AlertManager().showImageAlert(
                                      context: context,
                                      image: Img.cv,
                                      withDismiss: true,
                                    );
                                  },
                                  icon: Icon(
                                    CupertinoIcons.doc_person_fill,
                                    size: 35,
                                    color: context.primary,
                                  )),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: cubit.skills
                                .map((skill) => Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                              color: context.primary)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(skill.value,
                                            style: TextStyle(
                                                fontSize:
                                                    context.bodySmall.fontSize,
                                                color: context.textColor1)),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                        Divider(color: context.bg2),
                        SocialMediaView(cubit: cubit),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Rating',
                            style: TextStyle(
                                fontSize: context.bodyLarge.fontSize,
                                fontWeight: context.titleSmall.fontWeight)),
                        const SizedBox(
                          height: 10,
                        ),
                        ...VisitorRating.values.map((rating) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: [
                                VisitorRatingBuild(
                                  title: rating.value,
                                  selectedRating:
                                      cubit.ratings[rating]?.toInt() ?? 0,
                                  setRating: (value) {
                                    cubit.setRating(rating, value);
                                  },
                                ),
                                Divider(color: context.bg2),
                              ],
                            ),
                          );
                        }),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Comments',
                            style: TextStyle(
                                fontSize: context.bodyLarge.fontSize,
                                fontWeight: context.titleSmall.fontWeight)),
                        CustomTextField(
                          hintText: 'Comments',
                          controller: cubit.commentController,
                          validation: Validations.name,
                          borderRadius: 40,
                          min: 6,
                          max: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: SecondaryBtn(
                                    callback: () {
                                      AlertManager().showDefaultAlert(
                                          context: context,
                                          title: "Next Candidate",
                                          message:
                                              "Are you sure candidate NOT exist?",
                                          onConfirm: () {},
                                          onCancel: () {},
                                          secondaryBtnText: 'NOT Exist',
                                          primaryBtnText: 'Cancel');
                                    },
                                    title: "Not Exist")),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: PrimaryBtn(
                                  callback: () {
                                    AlertManager().showDefaultAlert(
                                        context: context,
                                        title: "Next Candidate",
                                        message:
                                            "Are you sure you want go to next candidate ?",
                                        onConfirm: () {},
                                        onCancel: () {},
                                        secondaryBtnText: 'Cancel',
                                        primaryBtnText: 'Next');
                                  },
                                  title: 'Next'),
                            )
                          ],
                        )
                      ],
                    );
                  },
                ),
              ],
            ),
          )),
        );
      }),
    );
  }
}
