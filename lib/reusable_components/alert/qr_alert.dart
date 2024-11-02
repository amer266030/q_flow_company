import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:q_flow_company/extensions/screen_size.dart';
import 'package:q_flow_company/mangers/data_mgr.dart';
import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_company/theme_data/extensions/theme_ext.dart';
import 'package:barcode_widget/barcode_widget.dart';

class QRAlert extends StatelessWidget {
  final String title;
  final Function()? onClose;

  const QRAlert({
    required this.onClose,
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var companyId = GetIt.I.get<DataMgr>().company?.id;
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color:  Colors.white,
                      borderRadius: BorderRadius.circular(24)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: onClose,
                        icon: Icon(
                          CupertinoIcons.xmark_circle_fill,
                          color: Colors.black,
                          size: 32,
                          weight: 40,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: BarcodeWidget(
                          height: context.screenHeight * 0.3,
                          barcode: Barcode.qrCode(),
                          data: companyId.toString(),
                        ),
                      ),
                    ],
                  )),
              Container(
                padding: EdgeInsets.all(24),
                width: context.screenWidth * 0.9,
                height: context.screenWidth * 0.2,
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: context.bg2)),
                    color: Colors.white,
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
