import 'ui_paste_component_platform_interface.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UIPastComponent extends StatefulWidget {
  final Function(String pasted) onPasted;

  const UIPastComponent({
    super.key,
    required this.onPasted,
  });

  @override
  State<UIPastComponent> createState() => _UIPastComponentState();
}

class _UIPastComponentState extends State<UIPastComponent> {
  @override
  void initState() {
    super.initState();
    UiPasteComponentPlatform.instance.setPasteMethod(widget.onPasted);
  }

  @override
  Widget build(BuildContext context) {
    const String viewType = 'paste_component';
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{};

    return UiKitView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
      hitTestBehavior: PlatformViewHitTestBehavior.translucent,
    );
  }
}
