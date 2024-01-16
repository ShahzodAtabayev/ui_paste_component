import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ui_paste_component_platform_interface.dart';

/// An implementation of [UiPasteComponentPlatform] that uses method channels.
class MethodChannelUiPasteComponent extends UiPasteComponentPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ui_paste_component');

  Function(String arguments)? _paste;

  MethodChannelUiPasteComponent() {
    methodChannel.setMethodCallHandler((call) {
      switch (call.method) {
        case "pasted":
          _paste?.call(call.arguments.toString());
          break;
        default:
      }
      return Future.value();
    });
  }

  @override
  void setPasteMethod(Function(String arguments) pasteMethod) async {
    _paste = pasteMethod;
  }
}
