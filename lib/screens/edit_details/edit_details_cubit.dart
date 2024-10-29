import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:q_flow_company/model/enum/company_size.dart';
import 'package:q_flow_company/model/user/company.dart';
import 'package:uuid/uuid.dart';

import '../position_opening/position_opening_screen.dart';

part 'edit_details_state.dart';

class EditDetailsCubit extends Cubit<EditDetailsState> {
  EditDetailsState? previousState;
  EditDetailsCubit(Company? company) : super(EditDetailsInitial()) {
    initialLoad(company);
  }
  var companyId = Uuid().v4().toString();

  File? logo;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final linkedInController = TextEditingController();
  final websiteController = TextEditingController();
  final xController = TextEditingController();
  DateTime startDate = DateTime.now();

  var companySize = CompanySize.zeroTo50;

  initialLoad(Company? company) {
    if (company?.id != null) {
      companyId = company!.id!;
    }
    nameController.text = company?.name ?? '';
    descriptionController.text = company?.description ?? '';
    companySize = company?.companySize ?? CompanySize.zeroTo50;

    // if (company?.establishedYear != null) {
    //   startDate = company!.establishedYear!;
    // }
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

  void emitLoading() => emit(LoadingState());
  void emitUpdate() => emit(UpdateUIState());
  emitError(String msg) => emit(ErrorState(msg));
}
