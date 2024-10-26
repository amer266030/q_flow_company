import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../position_opening/position_opening_screen.dart';

part 'edit_details_state.dart';

class EditDetailsCubit extends Cubit<EditDetailsState> {
  EditDetailsCubit() : super(EditDetailsInitial());
  File? logo;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final linkedInController = TextEditingController();
  final websiteController = TextEditingController();
  final xController = TextEditingController();

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
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const PositionOpeningScreen()));

  void emitLoading() => emit(LoadingState());
  void emitUpdate() => emit(UpdateUIState());
}
