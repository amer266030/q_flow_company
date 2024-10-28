import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_flow_company/reusable_components/dialog/error_dialog.dart';
import 'package:q_flow_company/reusable_components/dialog/loading_dialog.dart';
import 'package:q_flow_company/screens/auth/network_functions.dart';
import 'package:q_flow_company/screens/auth/subviews/login_form_view.dart';
import 'package:q_flow_company/screens/auth/subviews/otp_form_view.dart';
import '../../extensions/img_ext.dart';
import 'auth_cubit.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<AuthCubit>();
        return BlocListener<AuthCubit, AuthState>(
          listener: (context, state) async {
            if (cubit.previousState is LoadingState &&
                Navigator.canPop(context)) {
              Navigator.of(context)
                  .pop(); 
            }

            if (state is LoadingState && cubit.previousState is! LoadingState) {
              showLoadingDialog(context);
            }

            if (state is ErrorState) {
              showErrorDialog(context, state.msg);
            }
          },
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: ListView(children: [
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: ClipOval(
                          child: AspectRatio(
                        aspectRatio: 2.3,
                        child: Image(
                          image: Img.logo,
                        ),
                      )),
                    ),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return cubit.isOtp
                            ? OtpFormView(
                                email: cubit.emailController.text,
                                goBack: cubit.toggleIsOtp,
                                verifyOTP: (otp) =>
                                    cubit.verifyOTP(context, otp))
                            : LoginFormView(
                                callback: () => cubit.sendOTP(context),
                                controller: cubit.emailController);
                      },
                    )
                  ]),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
