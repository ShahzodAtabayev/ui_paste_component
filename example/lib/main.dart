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
      locale: Locale("ru"),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 52,
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
                              Visibility(
                                visible: false,
                                maintainSize: true,
                                maintainState: true,
                                maintainAnimation: true,
                                child: CupertinoTextSelectionToolbarButton.buttonItem(
                                  buttonItem: item,
                                ),
                              ),
                              Positioned.fill(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Transform.scale(
                                    scale: .88,
                                    child: UIPastComponent(
                                      onPasted: (pasted) {
                                        _textEditingController.selection.textInside(pasted);
                                        pasteItem.onPressed?.call();
                                      },
                                    ),
                                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}
