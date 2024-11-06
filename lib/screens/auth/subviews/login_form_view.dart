import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:q_flow_company/reusable_components/button/primary_btn.dart';
import 'package:q_flow_company/reusable_components/custom_text_field.dart';
import 'package:q_flow_company/reusable_components/page_header_view.dart';
import 'package:q_flow_company/screens/drawer/drawer_cubit.dart';
import 'package:q_flow_company/utils/validations.dart';

class LoginFormView extends StatelessWidget {
  const LoginFormView({required this.callback, required this.controller});
  final TextEditingController controller;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageHeaderView(title: 'Login'.tr()),
        CustomTextField(
            hintText: 'Email',
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            validation: Validations.email),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(child: PrimaryBtn(callback: callback, title: 'Start'))
          ],
        ),
      ],
    );
  }
}
