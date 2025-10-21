import 'package:flutter_test/flutter_test.dart';
import 'package:sparkle/main.dart';
import 'package:sparkle/screens/home_screen.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SparkleApp());

    // Verify that the app builds without crashing.
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
