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
    final Map<String, dynamic> creationParams = <String, dynamic>{};
    return SizedBox(
      width: double.infinity, // Expand to fill width
      child: UiKitView(
        viewType: viewType,
        creationParams: creationParams,
        layoutDirection: TextDirection.ltr,
        creationParamsCodec: const StandardMessageCodec(),
        hitTestBehavior: PlatformViewHitTestBehavior.translucent,
      ),
    );
  }
}
