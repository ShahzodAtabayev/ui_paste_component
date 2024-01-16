import 'package:flutter_test/flutter_test.dart';
import 'package:ui_paste_component/ui_paste_component_platform_interface.dart';
import 'package:ui_paste_component/ui_paste_component_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockUiPasteComponentPlatform with MockPlatformInterfaceMixin implements UiPasteComponentPlatform {
  @override
  void setPasteMethod(Function(String arguments) pasteMethod) {
    // TODO: implement setPasteMethod
  }
}

void main() {
  final UiPasteComponentPlatform initialPlatform = UiPasteComponentPlatform.instance;

  test('$MethodChannelUiPasteComponent is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelUiPasteComponent>());
  });

  test('getPlatformVersion', () async {
    MockUiPasteComponentPlatform fakePlatform = MockUiPasteComponentPlatform();
    UiPasteComponentPlatform.instance = fakePlatform;
  });
}
