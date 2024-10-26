import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

import '../home/home_screen.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  navigate(BuildContext context) {
    _navigateToEditDetails(context);
  }

  _navigateToEditDetails(BuildContext context) => Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));

  _navigateToHome(BuildContext context) => Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));
}
