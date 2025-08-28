// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:centre_de_don/main.dart'; // Ajoute l'import de ton app principale

void main() {
  testWidgets('Affiche le texte de bienvenue', (WidgetTester tester) async {
    await tester.pumpWidget(const RenaissanceApp());

    // Vérifie que le texte d'accueil et le titre sont présents dans l'app réelle
    expect(find.text('Centre de don'), findsOneWidget);
    // Si tu veux tester un texte spécifique de ta page d'accueil, ajoute-le ici :
    // expect(find.text('Bienvenue sur mon appli Flutter Web'), findsOneWidget);
  });
}
