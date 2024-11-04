import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:q_flow_company/model/user/company.dart';
import 'package:q_flow_company/reusable_components/animated_snack_bar.dart';
import 'package:q_flow_company/screens/edit_details/edit_details_screen.dart';
import 'package:q_flow_company/utils/validations.dart';

import '../../mangers/data_mgr.dart';
import '../home/home_screen.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthState? previousState;

  AuthCubit() : super(AuthInitial());

  final dataMgr = GetIt.I.get<DataMgr>();
  final TextEditingController emailController = TextEditingController();
  bool isOtp = false;
  Company? company;

  bool validateEmail(BuildContext context) {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      showSnackBar(
          context, 'Email cannot be empty.', AnimatedSnackBarType.warning);
      return false;
    }
    final validationMessage = Validations.email(email);
    if (validationMessage != null) {
      showSnackBar(context, validationMessage, AnimatedSnackBarType.warning);
      return false;
    }
    return true;
  }

  navigateToEditDetails(
    BuildContext context,
  ) =>
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const EditDetailsScreen(
                isInitialSetup: false,
              )));

  navigateToHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  void showSnackBar(
      BuildContext context, String msg, AnimatedSnackBarType type) {
    if (context.mounted) {
      animatedSnakbar(msg: msg, type: type).show(context);
    }
  }

  void toggleIsOtp() {
    isOtp = !isOtp;
    emitUpdate();
  }

  @override
  void emit(AuthState state) {
    previousState = this.state;
    super.emit(state);
  }

  void emitLoading() => emit(LoadingState());
  void emitUpdate() => emit(UpdateUIState());
  void emitError(String msg) => emit(ErrorState(msg));
}
