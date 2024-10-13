import 'dart:convert';
import 'package:e_store/utilities/constant/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../model/notification_model.dart';

class NotificationServices {
  final baseUrl = AppStrings.liveUrl;

  Future<List<NotificationModel>> getAllNotifications(
      BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('Authorization');
    List<NotificationModel> notificationList = [];
    try {
      final res = await http.get(
          Uri.parse('$baseUrl/api/v1/e-stores/notifications/all-notifications'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "Bearer $token",
          });
      if (res.statusCode == 200 || res.statusCode == 201) {
        final List<dynamic> responseData = jsonDecode(res.body)['data'];
        for (var notificationData in responseData) {
          notificationList.add(NotificationModel.fromMap(notificationData));
        }
      } else {
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      throw e;
    }
    return notificationList;
  }
}
