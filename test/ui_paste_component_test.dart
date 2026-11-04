import 'package:flutter_test/flutter_test.dart';
import 'package:ui_paste_component/ui_paste_component_platform_interface.dart';
import 'package:ui_paste_component/ui_paste_component_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockUiPasteComponentPlatform with MockPlatformInterfaceMixin implements UiPasteComponentPlatform {
  Function(String arguments)? pasteMethod;

  @override
  void setPasteMethod(Function(String arguments) pasteMethod) {
    this.pasteMethod = pasteMethod;
  }
}

void main() {
  final UiPasteComponentPlatform initialPlatform = UiPasteComponentPlatform.instance;

  test('$MethodChannelUiPasteComponent is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelUiPasteComponent>());
  });

  test('instance can be replaced and receives setPasteMethod', () {
    final fakePlatform = MockUiPasteComponentPlatform();
    UiPasteComponentPlatform.instance = fakePlatform;
    addTearDown(() => UiPasteComponentPlatform.instance = initialPlatform);

    void onPasted(String _) {}
    UiPasteComponentPlatform.instance.setPasteMethod(onPasted);

    expect(UiPasteComponentPlatform.instance, same(fakePlatform));
    expect(fakePlatform.pasteMethod, same(onPasted));
  });
}
