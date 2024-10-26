import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:q_flow_company/model/enum/queue_status.dart';

import '../../mock_data/visitor_data.dart';
import '../../model/enum/events.dart';
import '../../model/enum/visitor_status.dart';
import '../../model/user/visitor.dart';
import '../visitor_details.dart/visitor_details_screen.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    filterVisitors();
  }
  List<Visitor> filteredVisitors = [];
  VisitorStatus selectedVisitorStatus = VisitorStatus.inQueue;
  QueueStatus selectedQueueStatus = QueueStatus.close;

  Events? selectedEvent = Events.jobFair111;

  bool isOpenApplying = false;
  double queueLimit = 10;

  List<Visitor> visitor = [];

  initialLoad() {
    // TODO:- get Queue Status
    filterVisitors();
  }

  void filterBySize(String str) {
    selectedEvent =
        Events.values.where((e) => e.value == str).toList().firstOrNull;
    emitUpdate();
  }

  void toggleOpenApplying(int idx) {
    print('this function was called');
    selectedQueueStatus = QueueStatus.values[idx];
    emitUpdate();
  }

  setSelectedStatus(int idx) {
    selectedVisitorStatus = VisitorStatus.values[idx];
    filterVisitors();
    emitUpdate();
  }

  void filterVisitors() {
    filteredVisitors = filteredVisitors =
        visitors.where((v) => v.status == selectedVisitorStatus).toList();
    print("Filtered Visitors Count: ${filteredVisitors.length}"); // Debug line
    emit(UpdateUIState());
  }

  navigateToVisitorDetails(BuildContext context) => Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const VisitorDetailsScreen()));

  void emitUpdate() => emit(UpdateUIState());
}
