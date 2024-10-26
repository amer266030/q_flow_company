import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../extensions/img_ext.dart';
import '../../reusable_components/button/primary_btn.dart';
import '../../reusable_components/custom_text_field.dart';
import '../../reusable_components/page_header_view.dart';
import '../../utils/validations.dart';
import 'auth_cubit.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<AuthCubit>();
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(4),
                    child: ClipOval(
                        child: AspectRatio(
                      aspectRatio: 2.3,
                      child: Image(
                        image: Img.logo,
                      ),
                    )),
                  ),
                  const PageHeaderView(title: 'Login'),
                  Expanded(
                    child: ListView(
                      children: [
                        _FormView(cubit: cubit),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _FormView extends StatelessWidget {
  const _FormView({required this.cubit});
  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextField(
            hintText: 'Email',
            controller: TextEditingController(),
            validation: Validations.email),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
                child: PrimaryBtn(
                    callback: () => cubit.navigate(context), title: 'Start'))
          ],
        ),
      ],
    );
  }
}
