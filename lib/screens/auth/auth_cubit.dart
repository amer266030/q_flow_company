import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:q_flow_company/screens/edit_details/edit_details_screen.dart';

import '../home/home_screen.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
    AuthState? previousState;

  AuthCubit() : super(AuthInitial());

  final TextEditingController emailController = TextEditingController();
  bool isOtp = false;



  navigateToEditDetails(BuildContext context) =>
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const EditDetailsScreen()));

  navigateToHome(BuildContext context) =>
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));

@override
  void emit(AuthState state) {
    previousState = this.state;
    super.emit(state);
  }
  

  void toggleIsOtp() {
    isOtp = !isOtp;
    emitUpdate();
  }

  void emitLoading() => emit(LoadingState());

  void emitUpdate() => emit(UpdateUIState());
  void emitError(String msg) => emit(ErrorState(msg));
}
