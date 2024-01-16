import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_paste_component/ui_paste_component_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelUiPasteComponent platform = MethodChannelUiPasteComponent();
  const MethodChannel channel = MethodChannel('ui_paste_component');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  // test('getPlatformVersion', () async {
  //   expect(await platform.getPlatformVersion(), '42');
  // });
}
