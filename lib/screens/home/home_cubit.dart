import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:q_flow_company/mangers/data_mgr.dart';
import 'package:q_flow_company/model/enums/interview_status.dart';

import 'package:q_flow_company/model/user/company.dart';
import 'package:q_flow_company/screens/home/network_function.dart';

import '../../model/enums/queue_status.dart';
import '../../model/enums/visitor_status.dart';
import '../../model/event/event.dart';
import '../../model/interview.dart';
import '../../model/user/visitor.dart';
import '../visitor_details.dart/visitor_details_screen.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeState? previousState;
  HomeCubit() : super(HomeInitial()) {
    initialLoad();
  }

  var dataMgr = GetIt.I.get<DataMgr>();
  List<Event> events = [];

  Event? selectedEvent;
  var company = Company();
  List<Visitor> visitors = [];
  List<Visitor> filteredVisitors = [];
  List<Interview> interviews = [];
  VisitorStatus selectedVisitorStatus = VisitorStatus.inQueue;
  QueueStatus selectedQueueStatus = QueueStatus.close;

  double queueLimit = 10;

  initialLoad() async {
    try {
      if (dataMgr.company == null) throw Exception('Could not load company');
      company = dataMgr.company!;
      visitors = dataMgr.visitors;
      events = dataMgr.events;
      if (events.isNotEmpty) selectedEvent = events.first;
      interviews = await fetchInterviews();

      if (company.isQueueOpen != null) {
        selectedQueueStatus =
            company.isQueueOpen! ? QueueStatus.open : QueueStatus.close;
      }

      filterVisitors();
    } catch (e) {
      emitError(e.toString());
    }
    emitUpdate();
  }

  void selectEvent(String eventName) {
    selectedEvent =
        events.where((e) => e.name == eventName).toList().firstOrNull;
    emitUpdate();
  }

  void toggleOpenApplying(BuildContext context, int idx) async {
    selectedQueueStatus = QueueStatus.values[idx];

    if (selectedQueueStatus == QueueStatus.open) {
      await updateCompany(context, true);
    } else {
      await updateCompany(context, false);
    }

    emitUpdate();
  }

  toggleBookmark(BuildContext context, String visitorId) async {
    if (checkBookmark(visitorId)) {
      await deleteBookmark(context, visitorId);
    } else {
      await createBookmark(context, visitorId);
    }
  }

  bool checkBookmark(String visitorId) {
    if (company.bookmarkedVisitors != null) {
      return company.bookmarkedVisitors!.any((e) => e.visitorId == visitorId);
    }
    return false;
  }

  setSelectedStatus(int idx) {
    selectedVisitorStatus = VisitorStatus.values[idx];
    filterVisitors();
    emitUpdate();
  }

  void filterVisitors() {
    if (selectedVisitorStatus == VisitorStatus.inQueue) {
      var filteredInterviews = interviews
          .where((i) => i.status == InterviewStatus.upcoming)
          .toList();
      var visitorIds = filteredInterviews.map((e) => e.visitorId).toList();
      filteredVisitors =
          visitors.where((v) => visitorIds.contains(v.id)).toList();
    } else if (selectedVisitorStatus == VisitorStatus.applied) {
      var filteredInterviews = interviews
          .where((i) => i.status == InterviewStatus.completed)
          .toList();
      var visitorIds = filteredInterviews.map((e) => e.visitorId).toList();
      filteredVisitors =
          visitors.where((v) => visitorIds.contains(v.id)).toList();
    } else if (selectedVisitorStatus == VisitorStatus.saved) {
      var visitorIds =
          company.bookmarkedVisitors?.map((e) => e.visitorId).toList() ?? [];
      filteredVisitors =
          visitors.where((v) => visitorIds.contains(v.id)).toList();
    }

    emitUpdate();
  }

  navigateToVisitorDetails(BuildContext context) => Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const VisitorDetailsScreen()));

  @override
  void emit(HomeState state) {
    previousState = this.state;
    super.emit(state);
  }

  emitUpdate() => emit(UpdateUIState());
  emitError(String msg) => emit(ErrorState(msg));
  emitLoading() => emit(LoadingState());
}
