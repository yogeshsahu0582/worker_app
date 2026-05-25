import 'package:flutter/material.dart';

class WorkerStatusProvider extends ChangeNotifier {
  bool isOnline = false;

  void toggleStatus() {
    isOnline = !isOnline;

    notifyListeners();
  }
}
