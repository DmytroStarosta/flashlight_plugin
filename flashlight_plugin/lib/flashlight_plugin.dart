import 'dart:io';
import 'package:flutter/services.dart';

class FlashlightPlugin {
  static const MethodChannel _channel = MethodChannel('flashlight_plugin/methods');

  static Future<void> toggleFlash(bool isOn) async {
    if (!Platform.isAndroid) {
      throw PlatformException(
        code: 'NOT_SUPPORTED',
        message: 'Flashlight functionality is only supported on Android devices.',
      );
    }
    try {
      await _channel.invokeMethod('toggleFlash', {'isOn': isOn});
    } on PlatformException catch (_) {
      rethrow;
    }
  }
}