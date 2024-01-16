import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ui_paste_component_method_channel.dart';

abstract class UiPasteComponentPlatform extends PlatformInterface {
  /// Constructs a UiPasteComponentPlatform.
  UiPasteComponentPlatform() : super(token: _token);

  static final Object _token = Object();

  static UiPasteComponentPlatform _instance = MethodChannelUiPasteComponent();

  /// The default instance of [UiPasteComponentPlatform] to use.
  ///
  /// Defaults to [MethodChannelUiPasteComponent].
  static UiPasteComponentPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [UiPasteComponentPlatform] when
  /// they register themselves.
  static set instance(UiPasteComponentPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  void setPasteMethod(Function(String arguments) pasteMethod) {
    throw UnimplementedError('setPasteMethod() has not been implemented.');
  }
}
