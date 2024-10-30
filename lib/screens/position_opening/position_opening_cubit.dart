import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

import '../../model/enums/tech_skill.dart';
import '../home/home_screen.dart';

part 'position_opening_state.dart';

class PositionOpeningCubit extends Cubit<PositionOpeningState> {
  PositionOpeningCubit() : super(PositionOpeningInitial());
  List<TechSkill> positions = [];
  navigateToHome(BuildContext context) => Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()));

  positionTapped(TechSkill position) {
    positions.contains(position)
        ? positions.remove(position)
        : positions.add(position);
    emitUpdate();
  }

  emitLoading() => emit(LoadingState());
  emitUpdate() => emit(UpdateUIState());
}
