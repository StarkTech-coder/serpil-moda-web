import 'package:flutter_test/flutter_test.dart';
import 'package:serpil_moda_web/main.dart';

void main() {
  testWidgets('App loading and initial smoke test',
      (WidgetTester tester) async {
    // Start the application
    await tester.pumpWidget(const SerpilModaApp());

    // Verify that the 'SERPİL' text is present in the widget tree
    expect(find.textContaining('SERPİL'), findsWidgets);
  });
}
