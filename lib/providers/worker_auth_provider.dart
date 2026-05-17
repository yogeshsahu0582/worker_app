import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_service.dart';

class WorkerAuthProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();

  bool isLoading = false;

  Future<bool> loginWorker(String phone) async {
    try {
      isLoading = true;

      notifyListeners();

      Response response = await apiService.dio.post(
        "/auth/worker-login",

        data: {"phone": phone},
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString("worker_token", response.data["access_token"]);

      isLoading = false;

      notifyListeners();

      return true;
    } catch (e) {
      isLoading = false;

      notifyListeners();

      return false;
    }
  }
}
