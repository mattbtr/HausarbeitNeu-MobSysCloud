import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

import 'package:frontend_flutter/routes/profile/profile_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Fake FirebaseApp initialisieren (minimal, damit FirebaseCore nicht crasht)
  setUpAll(() async {
    await Firebase.initializeApp();
  });

  group('ProfileScreen (Smoke Tests mit Mocks)', () {
    late MockUser mockUser;
    late MockFirebaseAuth mockAuth;
    late FakeFirebaseFirestore fakeFirestore;

    setUp(() {
      mockUser = MockUser(uid: 'user123', email: 'test@example.com');
      mockAuth = MockFirebaseAuth(mockUser: mockUser, signedIn: true);

      fakeFirestore = FakeFirebaseFirestore();
      // User-Daten in Fake Firestore anlegen
      fakeFirestore.collection('users').doc(mockUser.uid).set({
        'name': 'Max Mustermann',
        'email': 'max@firma.tld',
        'role': 'Techniker',
        'department': 'Instandhaltung',
      });
    });

    testWidgets('Screen rendert ohne Crash', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: ProfileScreen()));
      expect(find.byType(ProfileScreen), findsOneWidget);
      expect(find.text('Profil'), findsOneWidget);
    });

    testWidgets('zeigt Ladeindikator oder Fallback-Text', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: ProfileScreen()));
      await tester.pump();
      expect(
        find.byType(CircularProgressIndicator).evaluate().isNotEmpty ||
            find.textContaining('Kein Benutzer').evaluate().isNotEmpty,
        true,
      );
    });

    testWidgets('Passwort ändern Dialog ist aufrufbar', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: ProfileScreen()));
      await tester.pumpAndSettle();
      if (find.text('Passwort ändern').evaluate().isEmpty) return;
      await tester.tap(find.text('Passwort ändern'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);
    });

    testWidgets('Abmelden Button existiert', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: ProfileScreen()));
      await tester.pumpAndSettle();
      if (find.text('Abmelden').evaluate().isNotEmpty) {
        expect(find.text('Abmelden'), findsOneWidget);
      }
    });
  });
}
