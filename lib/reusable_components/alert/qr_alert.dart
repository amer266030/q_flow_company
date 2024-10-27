import 'package:flutter/material.dart';

import 'package:q_flow_company/extensions/screen_size.dart';
import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_company/theme_data/extensions/theme_ext.dart';
import 'package:barcode_widget/barcode_widget.dart';


class QRAlert extends StatelessWidget {
  final ImageProvider qr;
  final String title;

  const QRAlert({
    Key? key,
    required this.qr,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.all(32),
                  decoration: BoxDecoration(
                      color: context.bg1,
                      borderRadius: BorderRadius.circular(20)),
                  child: BarcodeWidget(
                    height: context.screenHeight * 0.3,
                    barcode: Barcode.qrCode(),
                    data: "https://pub.dev/packages/barcode_widget",
                  )),
              Container(
                padding: EdgeInsets.all(24),
                width: context.screenWidth * 0.9,
                height: context.screenWidth * 0.2,
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: context.bg2)),
                    color: context.bg1,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontSize: context.titleSmall.fontSize,
                            fontWeight: context.titleSmall.fontWeight)),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
