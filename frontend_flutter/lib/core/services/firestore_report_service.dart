
// lib\core\services\firestore_report_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

// Firestore regelt:
// Offline
//Retry
//lokale Speicherung

class FirestoreReportService {
  static final _db = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;
  static const _uuid = Uuid();

  static Future<void> saveDraftReport({
    required String titel,
    required String beschreibung,
    required DateTime datum,
    required int anlageId,
  }) async {
    final user = _auth.currentUser!;

    final reportUuid = _uuid.v4(); // UUID erzeugen

    await _db.collection('draft_reports').add({
      'uuid':reportUuid,
      'titel': titel,
      'beschreibung': beschreibung,
      'datum': datum.toIso8601String(),
      'anlage_id': anlageId,

      'firebase_uid': user.uid,
      'nutzer_name': user.displayName,
      'nutzer_email': user.email,

      'sync_state': 'dirty', // <-- wichtig
      'synced': false,

      'last_modified': FieldValue.serverTimestamp(),
    });
  }
}
