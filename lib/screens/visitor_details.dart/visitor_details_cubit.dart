import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/enums/tech_skill.dart';
import '../../model/enums/visitor_rating.dart';

part 'visitor_details_state.dart';

class VisitorDetailsCubit extends Cubit<VisitorDetailsState> {
  VisitorDetailsCubit() : super(VisitorDetailsInitial()) {
    initialLoad();
  }
  final commentController = TextEditingController();
  Map<VisitorRating, double> ratings = {
    VisitorRating.technicalSkills: 0,
    VisitorRating.softSkills: 0,
    VisitorRating.jobSkills: 0,
  };
  void setRating(VisitorRating rating, double value) {
    ratings[rating] = value;
    emitUpdateUI();
  }

  navigateBack(BuildContext context) => Navigator.of(context).pop();
  List<TechSkill> skills = [];

  initialLoad() {
    skills = TechSkill.values.sublist(0, 5);
    emitUpdateUI();
  }

// call and email need to be test on phone
  Future<void> launchCall(String phoneNumber) async {
    final Uri urlParsed = Uri.parse('tel:$phoneNumber');

    if (await canLaunchUrl(urlParsed)) {
      await launchUrl(urlParsed);
    } else {
      throw 'Could not launch call to: $phoneNumber';
    }
  }

  Future<void> launchEmail(String visitorEmail) async {
    final String email = Uri.encodeComponent(visitorEmail);
    final Uri mail = Uri.parse("mailto:$email");

    try {
      final bool launched = await launchUrl(mail);
      if (launched) {
      } else {
        throw Exception('Could not launch email app');
      }
    } catch (e) {
      throw Exception('Error launching email: $e');
    }
  }

  Future<void> launchLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw Exception('Could not launch $url');
    }
  }

  emitUpdateUI() => emit(UpdateUIState());
}
