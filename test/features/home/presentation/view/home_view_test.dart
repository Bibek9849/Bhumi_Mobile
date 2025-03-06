import 'package:bhumi_mobile/features/home/presentation/view/home_view.dart';
import 'package:bhumi_mobile/features/home/presentation/view_model/home_cubit.dart';
import 'package:bhumi_mobile/features/home/presentation/view_model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'token.mock.dart'; // Ensure this file defines FakeTokenSharedPrefs.

/// A fake implementation of HomeCubit for testing.
class FakeHomeCubit extends HomeCubit {
  FakeHomeCubit() : super(FakeTokenSharedPrefs()) {
    emit(const HomeState(
      selectedIndex: 0,
      views: [
        Text('Dashboard View'),
        Text('Orders View'),
        Text('Profile View'),
      ],
      token: '',
    ));
  }

  @override
  void onTabTapped(int index) {
    emit(HomeState(
      selectedIndex: index,
      views: const [
        Text('Dashboard View'),
        Text('Orders View'),
        Text('Profile View'),
      ],
      token: '',
    ));
  }
}

void main() {
  group('HomeView Widget Tests', () {
    late FakeHomeCubit fakeHomeCubit;

    setUp(() {
      fakeHomeCubit = FakeHomeCubit();
    });

    testWidgets('renders the AppBar with title and logo',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HomeCubit>.value(
            value: fakeHomeCubit,
            child: const HomeView(),
          ),
        ),
      );

      // Check if AppBar is rendered.
      expect(find.byType(AppBar), findsOneWidget);
      // Verify that the title text is shown.
      expect(find.text('Bhumi'), findsOneWidget);
      // Check for the logo image.
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('displays the correct view when the Orders tab is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HomeCubit>.value(
            value: fakeHomeCubit,
            child: const HomeView(),
          ),
        ),
      );

      // Initially, the Dashboard View is visible.
      expect(find.text('Dashboard View'), findsOneWidget);

      // Instead of tapping the text, tap the GButton widget at index 1 (Orders).
      final ordersButton = find.byType(GButton).at(1);
      await tester.tap(ordersButton, warnIfMissed: false);
      await tester.pumpAndSettle();

      // Verify that the view has updated to "Orders View".
      expect(find.text('Orders View'), findsOneWidget);
    });

    testWidgets('displays the correct view when the Profile tab is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HomeCubit>.value(
            value: fakeHomeCubit,
            child: const HomeView(),
          ),
        ),
      );

      // Initially, the Dashboard View is visible.
      expect(find.text('Dashboard View'), findsOneWidget);

      // Tap the GButton widget at index 2 (Profile).
      final profileButton = find.byType(GButton).at(2);
      await tester.tap(profileButton, warnIfMissed: false);
      await tester.pumpAndSettle();

      // Verify that the view has updated to "Profile View".
      expect(find.text('Profile View'), findsOneWidget);
    });
  });
}
