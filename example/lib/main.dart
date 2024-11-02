import 'package:ui_paste_component/ui_paste_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  static int? getSystemVersion() {
    final intInStr = RegExp(r'\d+');
    final numbers = intInStr.allMatches(Platform.operatingSystemVersion).map((m) => m.group(0));
    return int.tryParse(numbers.firstOrNull ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final systemVersion = getSystemVersion() ?? 13;
    return MaterialApp(
      locale: const Locale("ru"),
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        final num constrainedTextScaleFactor = mediaQueryData.textScaleFactor.clamp(1.0, 1.25);
        return MediaQuery(
          data: mediaQueryData.copyWith(
            textScaleFactor: constrainedTextScaleFactor as double?,
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            textAlign: TextAlign.center,
            controller: _textEditingController,
            contextMenuBuilder: (context, editableTextState) {
              var children = <Widget>[];
              for (var item in editableTextState.contextMenuButtonItems) {
                if (item.type == ContextMenuButtonType.paste && (Platform.isIOS && systemVersion >= 16)) {
                  final pasteItem = item;
                  children.add(
                    Stack(
                      children: [
                        Positioned.fill(
                          child: UIPastComponent(
                            onPasted: (pasted) {
                              _textEditingController.selection.textInside(pasted);
                              pasteItem.onPressed?.call();
                            },
                          ),
                        ),
                        const Visibility(
                          visible: false,
                          maintainSize: true,
                          maintainState: true,
                          maintainAnimation: true,
                          child: CupertinoTextSelectionToolbarButton.text(text: "Paste"),
                        ),
                      ],
                    ),
                  );
                } else {
                  children.add(
                    CupertinoTextSelectionToolbarButton.buttonItem(
                      buttonItem: item,
                    ),
                  );
                }
              }
              return AdaptiveTextSelectionToolbar(
                anchors: editableTextState.contextMenuAnchors,
                children: children,
              );
            },
          ),
        ),
      ),
    );
  }

  TextStyle _kToolbarButtonFontStyle = TextStyle(
    inherit: false,
    fontSize: 15.0,
    letterSpacing: -0.15,
    fontWeight: FontWeight.w400,
  );
}
