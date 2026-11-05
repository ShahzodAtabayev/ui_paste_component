import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_paste_component/ui_paste_component_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MethodChannelUiPasteComponent platform;

  setUp(() {
    platform = MethodChannelUiPasteComponent();
  });

  tearDown(() {
    platform.methodChannel.setMethodCallHandler(null);
  });

  /// Simulates the native side invoking [method] on the plugin's channel.
  Future<void> sendFromNative(String method, [Object? arguments]) {
    const codec = StandardMethodCodec();
    return TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .handlePlatformMessage(
          platform.methodChannel.name,
          codec.encodeMethodCall(MethodCall(method, arguments)),
          (_) {},
        );
  }

  test('"pasted" from native calls the registered paste callback', () async {
    final pasted = <String>[];
    platform.setPasteMethod(pasted.add);

    await sendFromNative('pasted', 'hello');

    expect(pasted, ['hello']);
  });

  test('the latest paste callback wins', () async {
    final first = <String>[];
    final second = <String>[];
    platform.setPasteMethod(first.add);
    platform.setPasteMethod(second.add);

    await sendFromNative('pasted', 'text');

    expect(first, isEmpty);
    expect(second, ['text']);
  });

  test('unknown methods are ignored', () async {
    final pasted = <String>[];
    platform.setPasteMethod(pasted.add);

    await sendFromNative('somethingElse', 'ignored');

    expect(pasted, isEmpty);
  });
}
