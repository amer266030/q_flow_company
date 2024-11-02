import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:q_flow_company/mangers/data_mgr.dart';

import 'package:q_flow_company/model/user/company.dart';

import '../../model/enums/queue_status.dart';
import '../../model/enums/visitor_status.dart';
import '../../model/event/event.dart';
import '../../model/interview.dart';
import '../../model/user/visitor.dart';
import '../visitor_details.dart/visitor_details_screen.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    initialLoad();
  }

  var dataMgr = GetIt.I.get<DataMgr>();
  List<Event> events = [];

  Event? selectedEvent;
  Company? company;
  List<Visitor> visitor = [];
  List<Visitor> filteredVisitors = [];
  List<Interview> interviews = [];
  VisitorStatus selectedVisitorStatus = VisitorStatus.inQueue;
  QueueStatus selectedQueueStatus = QueueStatus.close;

  bool isOpenApplying = false;
  double queueLimit = 10;

  initialLoad() {
    filterVisitors();
  }

  void selectEvent(String eventName) {
    selectedEvent =
        events.where((e) => e.name == eventName).toList().firstOrNull;
    emitUpdate();
  }

  void toggleOpenApplying(int idx) {
    selectedQueueStatus = QueueStatus.values[idx];
    emitUpdate();
  }

  setSelectedStatus(int idx) {
    selectedVisitorStatus = VisitorStatus.values[idx];
    filterVisitors();
    emitUpdate();
  }

  void filterVisitors() {
    // filteredVisitors = filteredVisitors =
    //     visitors.where((v) => v.status == selectedVisitorStatus).toList();
    // print("Filtered Visitors Count: ${filteredVisitors.length}");
    emit(UpdateUIState());
  }

  navigateToVisitorDetails(BuildContext context) => Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const VisitorDetailsScreen()));

  emitUpdate() => emit(UpdateUIState());
  emitError(String msg) => emit(ErrorState(msg));
  emitLoading() => emit(LoadingState());
}
