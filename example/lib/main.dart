import 'package:ui_paste_component/ui_paste_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: TextField(
            controller: _textEditingController,
            textAlign: TextAlign.center,
            contextMenuBuilder: (context, editableTextState) {
              var children = <Widget>[];
              for (var item in editableTextState.contextMenuButtonItems) {
                if (item.type == ContextMenuButtonType.paste) {
                  final pasteItem = item;
                  children.add(
                    Stack(
                      children: [
                        Positioned.fill(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Transform.scale(
                              scale: 0.88,
                              child: UIPastComponent(
                                onPasted: (pasted) {
                                  _textEditingController.selection.textInside(pasted);
                                  pasteItem.onPressed?.call();
                                },
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: false,
                          maintainAnimation: true,
                          maintainSize: true,
                          maintainState: true,
                          child: CupertinoTextSelectionToolbarButton.buttonItem(
                            buttonItem: item,
                          ),
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
}
