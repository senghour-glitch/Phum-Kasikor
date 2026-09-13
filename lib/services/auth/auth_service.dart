import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phum_kasikor/core/routes/app_routes.dart';

class AuthService extends GetxService {
  static const _sessionTimeout = Duration(minutes: 30);
  Timer? _sessionTimer;

  bool get isAuthenticated => _sessionTimer != null;

  @override
  void onInit() {
    super.onInit();
    _startSessionTimer();
  }

  void _startSessionTimer() {
    _sessionTimer?.cancel();
    _sessionTimer = Timer.periodic(_sessionTimeout, (_) {
      Get.offAllNamed(AppRoutes.login);
    });
  }

  void resetSessionTimer() {
    _startSessionTimer();
  }

  void dispose() {
    _sessionTimer?.cancel();
    super.dispose();
  }
}