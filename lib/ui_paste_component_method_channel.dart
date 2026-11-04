import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ui_paste_component_platform_interface.dart';

/// An implementation of [UiPasteComponentPlatform] that uses method channels.
class MethodChannelUiPasteComponent extends UiPasteComponentPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ui_paste_component');

  Function(String arguments)? _paste;

  @override
  void setPasteMethod(Function(String arguments) pasteMethod) {
    _paste = pasteMethod;
    // Registered lazily (not in the constructor) so that creating the default
    // platform instance does not require an initialized binary messenger.
    methodChannel.setMethodCallHandler(_handleMethodCall);
  }

  Future<void> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'pasted':
        _paste?.call(call.arguments.toString());
    }
  }
}
