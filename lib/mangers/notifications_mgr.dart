import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class NotificationsMgr {
  static Future<void> sendNotificationToUser(
      {required String externalId, required String msg}) async {
    try {
      await http.post(
        Uri.parse('https://onesignal.com/api/v1/notifications'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Basic ${dotenv.env['ONESIGNAL_RESTAPI_KEY']}',
        },
        body: jsonEncode({
          'app_id': dotenv.env['ONESIGNAL_KEY'],
          "target_channel": "push",
          "include_aliases": {
            "external_id": [externalId]
          },
          'contents': {'en': msg},
          "content_available": true
        }),
      );
    } catch (e) {
      rethrow;
    }
  }
}
