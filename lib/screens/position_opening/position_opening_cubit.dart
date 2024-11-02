import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../mangers/data_mgr.dart';
import '../../model/enums/tech_skill.dart';
import '../home/home_screen.dart';

part 'position_opening_state.dart';

class PositionOpeningCubit extends Cubit<PositionOpeningState> {
  PositionOpeningCubit() : super(PositionOpeningInitial()) {
    initialLoad();
  }

  PositionOpeningState? previousState;
  final dataMgr = GetIt.I.get<DataMgr>();
  List<TechSkill> positions = [];

  initialLoad() {
    var company = dataMgr.company;
    if (company?.skills != null) {
      for (var skill in company!.skills!) {
        if (skill.techSkill != null) {
          positions.contains(skill.techSkill!)
              ? positions.remove(skill.techSkill!)
              : positions.add(skill.techSkill!);
        }
      }
    }
  }

  navigateToHome(BuildContext context) => Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()));

  positionTapped(TechSkill position) {
    positions.contains(position)
        ? positions.remove(position)
        : positions.add(position);
    emitUpdate();
  }

  @override
  void emit(PositionOpeningState state) {
    previousState = this.state;
    super.emit(state);
  }

  emitLoading() => emit(LoadingState());
  emitUpdate() => emit(UpdateUIState());
  emitError(msg) => emit(ErrorState(msg));
}
