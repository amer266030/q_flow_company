import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_flow_company/model/enums/tech_skill.dart';
import 'package:q_flow_company/screens/visitor_details.dart/network_functions.dart';

import 'package:q_flow_company/screens/visitor_details.dart/subviews/social_media_view.dart';
import 'package:q_flow_company/screens/visitor_details.dart/visitor_details_cubit.dart';
import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_company/theme_data/extensions/theme_ext.dart';

import '../../extensions/img_ext.dart';
import '../../mangers/alert_manger.dart';

import '../../model/interview.dart';
import '../../model/user/visitor.dart';
import '../../reusable_components/button/book_mark_btn.dart';
import '../../reusable_components/button/primary_btn.dart';
import '../../reusable_components/button/secondary_btn.dart';
import '../../reusable_components/custom_text_field.dart';
import '../../reusable_components/dialog/error_dialog.dart';
import '../../reusable_components/dialog/loading_dialog.dart';
import '../../reusable_components/star_rating_view.dart';
import '../../reusable_components/visitor_avatar.dart';
import '../../utils/validations.dart';

class VisitorDetailsScreen extends StatelessWidget {
  const VisitorDetailsScreen({super.key, required this.interview});

  final Interview interview;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VisitorDetailsCubit(interview),
      child: Builder(builder: (context) {
        final cubit = context.read<VisitorDetailsCubit>();
        return BlocListener<VisitorDetailsCubit, VisitorDetailsState>(
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
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child:
                      BookMarkbtn(isBookmarked: false, toggleBookmark: () {}),
                )
              ],
            ),
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _HeaderView(visitor: cubit.visitor ?? Visitor()),
                      _SkillsView(visitor: cubit.visitor ?? Visitor()),
                      Divider(color: context.bg2),
                      SocialMediaView(cubit: cubit),
                      BlocBuilder<VisitorDetailsCubit, VisitorDetailsState>(
                        builder: (context, state) {
                          return _RatingView(cubit: cubit);
                        },
                      ),
                      Text('Comments',
                          style: TextStyle(
                              fontSize: context.bodyLarge.fontSize,
                              fontWeight: context.titleSmall.fontWeight)),
                      CustomTextField(
                        hintText: 'The candidate showed strong knowledge in...',
                        controller: cubit.commentController,
                        validation: Validations.name,
                        borderRadius: 32,
                        min: 6,
                        max: 10,
                      ),
                      const SizedBox(height: 24),
                      _ButtonsView(cubit: cubit)
                    ],
                  ),
                ],
              ),
            )),
          ),
        );
      }),
    );
  }
}

class _RatingView extends StatelessWidget {
  const _RatingView({super.key, required this.cubit});

  final VisitorDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              Text('Evaluation:',
                  style: TextStyle(
                      fontSize: context.bodyLarge.fontSize,
                      fontWeight: context.titleSmall.fontWeight)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: cubit.questions
                  .asMap()
                  .entries
                  .map(
                    (entry) => StarRatingView(
                      title: entry.value.title ?? '',
                      text: entry.value.text ?? '',
                      selectedRating: cubit.ratings[entry.key],
                      setRating: (rating) => cubit.setRating(entry.key, rating),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillsView extends StatelessWidget {
  const _SkillsView({
    super.key,
    required this.visitor,
  });

  final Visitor visitor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: (visitor.skills != null)
              ? visitor.skills!
                  .map((skill) => Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: context.primary)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(skill.techSkill?.value ?? '',
                              style: TextStyle(
                                  fontSize: context.bodySmall.fontSize,
                                  color: context.textColor1)),
                        ),
                      ))
                  .toList()
              : [const Text('')]),
    );
  }
}

class _HeaderView extends StatelessWidget {
  const _HeaderView({
    super.key,
    required this.visitor,
  });

  final Visitor visitor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipOval(
                  child: visitor.avatarUrl == null
                      ? const VisitorAvatar()
                      : FadeInImage(
                          placeholder: Img.logoPurple,
                          image: NetworkImage(visitor.avatarUrl!),
                          fit: BoxFit.contain,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return const Image(
                                image: Img.avatar, fit: BoxFit.cover);
                          },
                        ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${visitor.fName} ${visitor.lName}',
                    style: context.titleSmall),
                const SizedBox(height: 4),
                Text('${visitor.id?.substring(0, 13)}',
                    style: context.bodyMedium),
              ],
            ),
          ),
          IconButton(
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
              ))
        ],
      ),
    );
  }
}

class _ButtonsView extends StatelessWidget {
  const _ButtonsView({required this.cubit});

  final VisitorDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: SecondaryBtn(
                callback: () {
                  AlertManager().showDefaultAlert(
                      context: context,
                      title: "Skip Interview",
                      message: "mark the interview as cancelled?",
                      onConfirm: () => cubit.interviewCancelled(context),
                      onCancel: () {},
                      secondaryBtnText: 'No',
                      primaryBtnText: 'Yes');
                },
                title: "Skip")),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: PrimaryBtn(
              callback: () {
                AlertManager().showDefaultAlert(
                    context: context,
                    title: "Complete Interview",
                    message: "Save remarks and go to next candidate?",
                    onConfirm: () => cubit.interviewCompleted(context),
                    onCancel: () {},
                    secondaryBtnText: 'Cancel',
                    primaryBtnText: 'Yes');
              },
              title: 'Complete'),
        )
      ],
    );
  }
}
