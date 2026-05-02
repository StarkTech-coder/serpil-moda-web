import 'package:flutter_test/flutter_test.dart';
import 'package:serpil_moda_web/main.dart';

void main() {
  testWidgets('Uygulama yükleme testi', (WidgetTester tester) async {
    await tester.pumpWidget(const SerpilModaApp());

    expect(find.textContaining('SERPİL'), findsWidgets);
  });
}
