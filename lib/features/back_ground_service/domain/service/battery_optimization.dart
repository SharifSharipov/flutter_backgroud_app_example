import 'package:flutter/services.dart';

class BatteryOptimizationService {
  static const platform = MethodChannel('com.example.battery_optimization');

  Future<bool> isIgnoringBatteryOptimizations() async {
    try {
      final bool result = await platform.invokeMethod('isIgnoringBatteryOptimizations');
      return result;
    } on PlatformException catch (e) {
      print("Failed to check battery optimization status: '${e.message}'.");
      return false;
    }
  }

  Future<void> requestIgnoreBatteryOptimizations() async {
    try {
      await platform.invokeMethod('requestIgnoreBatteryOptimizations');
    } on PlatformException catch (e) {
      print("Failed to request ignoring battery optimizations: '${e.message}'.");
    }
  }
}
