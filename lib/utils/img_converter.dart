import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ImgConverter {
  static Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String), fit: BoxFit.cover);
  }

  static Image imageFromBytes(Uint8List bytes) {
    return Image.memory(bytes, fit: BoxFit.cover);
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List bytes) {
    return base64Encode(bytes);
  }

  static Future<List<int>> assetImgToIntList(AssetImage img) async {
    final ByteData bytes = await rootBundle.load(img.assetName);
    return bytes.buffer.asUint8List().toList();
  }

  static Future<Uint8List> assetImgToBytes(AssetImage img) async {
    final ByteData bytes = await rootBundle.load(img.assetName);
    return bytes.buffer.asUint8List();
  }

  static Future<List<int>> bytesImageToList(Uint8List img) async {
    return img.toList();
  }

  static Future<String> assetImgToBase64(AssetImage img) async {
    final Uint8List data = await assetImgToBytes(img);
    final String base64Image = base64Encode(data);
    return base64Image;
  }

  static Future<Uint8List> fileImgToBytes(File imageFile) async {
    return await imageFile.readAsBytes();
  }

  static Future<String> fileImgToBase64(File imageFile) async {
    final Uint8List imageBytes = await imageFile.readAsBytes();
    return base64Encode(imageBytes);
  }

  static Future<List<int>> fileImgToIntList(File imageFile) async {
    final Uint8List imageBytes = await imageFile.readAsBytes();
    return imageBytes.buffer.asUint8List().toList();
  }
}
