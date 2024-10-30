import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:q_flow_company/extensions/date_ext.dart';
import 'package:q_flow_company/mangers/data_mgr.dart';

import 'package:q_flow_company/model/user/company.dart';
import 'package:uuid/uuid.dart';

import '../../model/enums/company_size.dart';
import '../../model/enums/user_social_link.dart';
import '../position_opening/position_opening_screen.dart';

part 'edit_details_state.dart';

class EditDetailsCubit extends Cubit<EditDetailsState> {
  EditDetailsCubit(Company? company) : super(EditDetailsInitial()) {
    initialLoad(company);
  }
  EditDetailsState? previousState;
  final dataMgr = GetIt.I.get<DataMgr>();
  var companyId = const Uuid().v4().toString();

  File? logoFile;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final linkedInController = TextEditingController();
  final websiteController = TextEditingController();
  final xController = TextEditingController();
  DateTime startDate = DateTime.now();

  var companySize = CompanySize.zeroTo50;

  initialLoad(Company? company) {
    if (company != null) {
      nameController.text = company.name ?? '';
      descriptionController.text = company.description ?? '';
      companySize = company.companySize ?? CompanySize.zeroTo50;
      if (company.establishedYear != null) {
        startDate = '01/01/${company.establishedYear!}'.toDate();
      }
      if (company.socialLinks != null && company.socialLinks!.isNotEmpty) {
        for (var link in company.socialLinks!) {
          switch (link.linkType) {
            case LinkType.linkedIn:
              linkedInController.text = link.url ?? '';
            case LinkType.website:
              websiteController.text = link.url ?? '';
            case LinkType.twitter:
              xController.text = link.url ?? '';
            default:
          }
        }
      }
    }
  }

  void getImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      logoFile = File(img.path);
      emitUpdate();
    }
  }

  navigateToPositionOpening(BuildContext context) =>
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const PositionOpeningScreen()));
  navigateBack(BuildContext context) => Navigator.of(context).pop();

  updateStartDate(DateTime date) {
    startDate = date;
    emitUpdate();
  }

  setSize(CompanySize selectedSize) {
    companySize = selectedSize;
    emitUpdate();
  }

  @override
  void emit(EditDetailsState state) {
    previousState = this.state;
    super.emit(state);
  }

  void emitLoading() => emit(LoadingState());
  void emitUpdate() => emit(UpdateUIState());
  emitError(String msg) => emit(ErrorState(msg));
}
