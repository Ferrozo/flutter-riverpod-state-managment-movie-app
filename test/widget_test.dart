import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_movie_app/src/presentation/screens/export_screens.dart';

void main() {
  testWidgets('movie riverpod app', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);
  });
}
