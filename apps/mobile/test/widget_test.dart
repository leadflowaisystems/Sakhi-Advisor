import 'package:flutter_test/flutter_test.dart';
import 'package:sakhi_advisor/main.dart';

void main() {
  testWidgets('SakhiApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SakhiApp());
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(SakhiApp), findsOneWidget);
  });
}
