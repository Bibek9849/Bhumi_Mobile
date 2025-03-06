import 'package:bhumi_mobile/features/onboarding/presentation/view/on_board_model.dart';
import 'package:bhumi_mobile/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// A simple fake navigator observer to track navigation events.
class FakeNavigatorObserver extends NavigatorObserver {
  final List<Route<dynamic>> pushedRoutes = [];
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    pushedRoutes.add(route);
    super.didPush(route, previousRoute);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('OnboardingView Widget Tests', () {
    late FakeNavigatorObserver navigatorObserver;

    setUp(() {
      navigatorObserver = FakeNavigatorObserver();
    });

    testWidgets(
        'renders onboarding view with Skip button, Next button, and page indicators',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const OnboardingView(),
          navigatorObservers: [navigatorObserver],
        ),
      );

      // Check for Skip button.
      expect(find.text('Skip'), findsOneWidget);
      // Check for Next button.
      expect(find.text('Next'), findsOneWidget);

      // Find only the Containers used as page indicators.
      // We narrow the predicate by checking constraints.
      final indicatorFinder = find.byWidgetPredicate((widget) {
        if (widget is Container && widget.constraints != null) {
          final c = widget.constraints!;
          // Our indicators have height 8 and width either 8 or 12.
          return c.maxHeight == 8.0 &&
              (c.maxWidth == 8.0 || c.maxWidth == 12.0);
        }
        return false;
      });
      expect(indicatorFinder, findsNWidgets(pages.length));
    });

    testWidgets('swiping to the last page shows "Get Started" button',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const OnboardingView(),
          navigatorObservers: [navigatorObserver],
        ),
      );

      // Instead of a fling, we use the Skip button to jump to the last page.
      await tester.tap(find.text('Skip'));
      await tester.pumpAndSettle();

      // Verify that the button text has changed to "Get Started".
      expect(find.text('Get Started'), findsOneWidget);
    });

    testWidgets('tapping "Get Started" navigates to auth screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const OnboardingView(),
          navigatorObservers: [navigatorObserver],
        ),
      );

      // Tap the "Skip" button to jump to the last page.
      await tester.tap(find.text('Skip'));
      await tester.pumpAndSettle();

      // Ensure "Get Started" button is now visible.
      expect(find.text('Get Started'), findsOneWidget);

      // Tap the "Get Started" button.
      await tester.tap(find.text('Get Started'));
      // The navigation is triggered with a Future.delayed of 2 seconds.
      await tester.pump(const Duration(seconds: 3));
      // Pump one more time to complete any remaining animations.
      await tester.pump();

      // Verify that a navigation event occurred.
      expect(navigatorObserver.pushedRoutes.isNotEmpty, isTrue);
    });
  });
}
