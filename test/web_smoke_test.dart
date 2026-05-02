import 'package:flutter_test/flutter_test.dart';
import 'package:serpil_moda_web/main.dart'; // Ensure this path is correct and matches your project structure

void main() {
  testWidgets('Uygulama yükleme testi', (WidgetTester tester) async {
    // Uygulamayı başlat
    await tester.pumpWidget(
        const SerpilModaApp()); // Ensure SerpilModaApp is defined in the imported file

    // Başlıkta 'SERPİL MODA' yazısının olup olmadığını kontrol et
    expect(find.textContaining('SERPİL'), findsWidgets);
  });
}
