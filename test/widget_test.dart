// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:mapa_cultural_santaluzia/app.dart';

void main() {
  testWidgets('Exibe texto de boas vindas na página inicial', (tester) async {
    await tester.pumpWidget(const MapaCulturalApp());

    expect(
      find.text('Descubra Famosos Incríveis na Sua Região'),
      findsOneWidget,
    );
    expect(find.textContaining('Conecte-se com famosos'), findsOneWidget);
  });
}
