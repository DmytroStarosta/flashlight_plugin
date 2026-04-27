import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flashlight_plugin_method_channel.dart';

abstract class FlashlightPluginPlatform extends PlatformInterface {
  /// Constructs a FlashlightPluginPlatform.
  FlashlightPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlashlightPluginPlatform _instance = MethodChannelFlashlightPlugin();

  /// The default instance of [FlashlightPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlashlightPlugin].
  static FlashlightPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlashlightPluginPlatform] when
  /// they register themselves.
  static set instance(FlashlightPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
