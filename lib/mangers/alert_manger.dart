import 'package:flutter/material.dart';

import '../reusable_components/alert/custom_alert.dart';
import '../reusable_components/alert/qr_alert.dart';

class AlertManager {
  static final AlertManager _instance = AlertManager._internal();
  bool _isAlertVisible = false;

  factory AlertManager() {
    return _instance;
  }

  AlertManager._internal();

  void showImageAlert({
    required BuildContext context,
    required ImageProvider image,
    required bool withDismiss,
  }) {
    dismissPreviousAlert(context);
    showDialog(
      context: context,
      barrierDismissible: withDismiss,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Image(image: image),
        );
      },
    ).then((_) {
      _isAlertVisible = false;
    });
    _isAlertVisible = true;
  }

  void showDefaultAlert({
    required BuildContext context,
    required String title,
    required String secondaryBtnText,
    required String primaryBtnText,
    required String message,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
  }) {
    dismissPreviousAlert(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlert(
          title: title,
          secondaryBtnText: secondaryBtnText,
          primaryBtnText: primaryBtnText,
          message: message,
          onConfirm: () {
            onConfirm();
            dismiss(context);
          },
          onCancel: () {
            onCancel();
            dismiss(context);
          },
        );
      },
    ).then((_) {
      _isAlertVisible = false;
    });
    _isAlertVisible = true;
  }

  void showQRAlert({
    required BuildContext context,
    required String title,
    String? subTitle,
    required ImageProvider qr,
  }) {
    dismissPreviousAlert(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return QRAlert(
          qr: qr,
          title: title,
        );
      },
    ).then((_) {
      _isAlertVisible = false;
    });
    _isAlertVisible = true;
  }

  void dismiss(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
    _isAlertVisible = false;
  }

  void dismissPreviousAlert(BuildContext context) {
    if (_isAlertVisible) {
      dismiss(context);
    }
  }
}
