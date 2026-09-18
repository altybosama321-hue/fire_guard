import 'package:fire_guard/screens/splash_screen.dart';
import 'package:fire_guard/widgets/fire_guard_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Splash screen displays the FireGuard logo', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SplashScreen()));

    expect(find.byType(FireGuardLogo), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
  });
}
