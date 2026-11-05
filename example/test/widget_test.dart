import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ui_paste_component_example/main.dart';

void main() {
  testWidgets('App builds with material_ui localizations', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    // Fails with "No MaterialLocalizations found" if the app registers the
    // flutter_localizations delegates instead of the material_ui ones.
    expect(tester.takeException(), isNull);
    expect(find.widgetWithText(AppBar, 'Plugin example app'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });
}
