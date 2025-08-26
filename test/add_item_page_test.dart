import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:centre_de_don/add_item_page.dart';

void main() {
  testWidgets('add item page shows form errors when fields are empty', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: AddItemPage()));

    await tester.tap(find.text('Suggérer'));
    await tester.pump();

    expect(find.text('Ce champ est obligatoire'), findsNWidgets(2));
  });
}