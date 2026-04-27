import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flashlight_plugin_platform_interface.dart';

/// An implementation of [FlashlightPluginPlatform] that uses method channels.
class MethodChannelFlashlightPlugin extends FlashlightPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flashlight_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }
}
