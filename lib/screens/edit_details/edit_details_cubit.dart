import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:q_flow_company/mangers/data_mgr.dart';
import 'package:q_flow_company/model/enum/company_size.dart';
import 'package:q_flow_company/model/user/company.dart';
import 'package:uuid/uuid.dart';

import '../position_opening/position_opening_screen.dart';

part 'edit_details_state.dart';

class EditDetailsCubit extends Cubit<EditDetailsState> {
  EditDetailsCubit(Company? company) : super(EditDetailsInitial()) {
    initialLoad(company);
  }
  EditDetailsState? previousState;
  final dataMgr = GetIt.I.get<DataMgr>();
  var companyId = const Uuid().v4().toString();

  File? logo;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final linkedInController = TextEditingController();
  final websiteController = TextEditingController();
  final xController = TextEditingController();
  DateTime startDate = DateTime.now();

  var companySize = CompanySize.zeroTo50;

  initialLoad(Company? company) {
    var dataMgr = GetIt.I.get<DataMgr>();

    if (company != null) {
      // If a company is passed, initialize with that company data
      companyId = company.id ?? companyId;
      nameController.text = company.name ?? '';
      descriptionController.text = company.description ?? '';
      companySize = company.companySize ?? CompanySize.zeroTo50;
      startDate = DateTime(company.establishedYear ?? DateTime.now().year);
    }
    if (dataMgr.company != null) {
      var companyData = dataMgr.company!;
      companyId = companyData.id ?? const Uuid().v4().toString();
      nameController.text = companyData.name ?? '';
      descriptionController.text = companyData.description ?? '';
      companySize = companyData.companySize ?? CompanySize.zeroTo50;
      startDate = DateTime(companyData.establishedYear ?? DateTime.now().year);
    }
  }

  ImageProvider? get logoImage {
    return logo != null
        ? FileImage(logo!)
        : null; // Return FileImage if logo is set
  }

  void getImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      logo = File(img.path);
      emitUpdate(); // Emit update after setting the logo
    }
  }

  navigateToPositionOpening(BuildContext context) =>
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const PositionOpeningScreen()));

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
