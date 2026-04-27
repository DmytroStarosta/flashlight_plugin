import 'package:flutter_test/flutter_test.dart';
//import 'package:flashlight_plugin/flashlight_plugin.dart';
import 'package:flashlight_plugin/flashlight_plugin_platform_interface.dart';
import 'package:flashlight_plugin/flashlight_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlashlightPluginPlatform
    with MockPlatformInterfaceMixin
    implements FlashlightPluginPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlashlightPluginPlatform initialPlatform = FlashlightPluginPlatform.instance;

  test('$MethodChannelFlashlightPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlashlightPlugin>());
  });

  test('getPlatformVersion', () async {
    //FlashlightPlugin flashlightPlugin = FlashlightPlugin();
    MockFlashlightPluginPlatform fakePlatform = MockFlashlightPluginPlatform();
    FlashlightPluginPlatform.instance = fakePlatform;

   // expect(await flashlightPlugin.getPlatformVersion(), '42');
  });
}
