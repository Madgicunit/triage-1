// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('Affiche le texte de bienvenue', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Centre de don')),
        body: Center(child: Text('Bienvenue sur l\'appli de triage Web de Reinaissance')),
      ),
    ));

    expect(find.text('Bienvenue sur mon appli Flutter Web'), findsOneWidget);
    expect(find.text('Centre de don'), findsOneWidget);
  // Verify that our counter has incremented.
  // expect(find.text('0'), findsNothing);
  // expect(find.text('1'), findsOneWidget);
  });
}
