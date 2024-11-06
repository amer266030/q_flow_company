import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:q_flow_company/mangers/data_mgr.dart';
import 'package:q_flow_company/model/rating/visitor_rating_question.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/interview.dart';
import '../../model/user/visitor.dart';

part 'visitor_details_state.dart';

class VisitorDetailsCubit extends Cubit<VisitorDetailsState> {
  VisitorDetailsState? previousState;
  VisitorDetailsCubit(Interview interview) : super(VisitorDetailsInitial()) {
    initialLoad(interview);
  }

  final commentController = TextEditingController();

  final dataMgr = GetIt.I.get<DataMgr>();
  Visitor? visitor;
  var interview = Interview();
  List<VisitorRatingQuestion> questions = [];
  List<int> ratings = [];

  // Interview Stream with initial value
  static final _interviewController =
      StreamController<List<Interview>>.broadcast();
  static Stream<List<Interview>> get interviewStream =>
      _interviewController.stream;
  List<Interview> interviews = [];

  initialLoad(Interview interview) {
    this.interview = interview;
    visitor = getVisitor();
    questions = dataMgr.ratingQuestions;
    ratings = List.generate(questions.length, (index) => 1);
    emitUpdate();
  }

  Visitor? getVisitor() {
    return dataMgr.visitors
        .where((v) => v.id == interview.visitorId)
        .toList()
        .firstOrNull;
  }

  void setRating(int idx, double rating) {
    ratings[idx] = rating.round();
    emitUpdate();
  }

  navigateBack(BuildContext context) => Navigator.of(context).pop();

  Future<void> launchCall(String phoneNumber) async {
    try {
      final Uri urlParsed = Uri.parse('tel:$phoneNumber');

      if (await canLaunchUrl(urlParsed)) {
        await launchUrl(urlParsed);
      } else {
        throw 'CouldNotLaunch$phoneNumber'.tr();
      }
    } catch (e) {
      emitError(e.toString());
    }
  }

  Future<void> launchEmail(String visitorEmail) async {
    try {
      final String email = Uri.encodeComponent(visitorEmail);
      final Uri mail = Uri.parse("mailto:$email");

      final bool launched = await launchUrl(mail);
      if (launched) {
      } else {
        throw Exception('launchEmail'.tr());
      }
    } catch (e) {
      emitError(e.toString());
    }
  }

  Future<void> launchLink(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw Exception('URL $url'.tr());
      }
    } catch (e) {
      emitError(e.toString());
    }
  }

  @override
  void emit(VisitorDetailsState state) {
    previousState = this.state;
    super.emit(state);
  }

  emitUpdate() => emit(UpdateUIState());
  emitError(String msg) => emit(ErrorState(msg));
  emitLoading() => emit(LoadingState());
}
