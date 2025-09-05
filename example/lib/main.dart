import 'package:flutter_localizations/flutter_localizations.dart';
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
      supportedLocales: const [
        Locale('ru'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
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
              final localeCode = Localizations.localeOf(context).languageCode;
              final Map<String, double> localeWidthMap = {
                'en': 80,
                'ru': 130,
                'uz': 110,
                'de': 120,
                'fr': 115,
                'es': 110,
              };
              const defaultWidth = 135.0;
              final adaptiveWidth = localeWidthMap[localeCode] ?? defaultWidth;
              final systemVersion = _MyAppState.getSystemVersion();
              final children = <Widget>[];
              for (var item in editableTextState.contextMenuButtonItems) {
                if (item.type == ContextMenuButtonType.paste && Platform.isIOS && systemVersion! >= 16) {
                  final pasteItem = item;
                  children.add(
                    SizedBox(
                      width: adaptiveWidth, // yoki AdaptiveWidth qiling istasangiz
                      child: UIPastComponent(
                        onPasted: (pasted) {
                          _textEditingController.text = pasted;
                          pasteItem.onPressed?.call();
                        },
                      ),
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
