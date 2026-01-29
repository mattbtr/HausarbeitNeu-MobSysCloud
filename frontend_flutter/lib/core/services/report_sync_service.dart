// lib\core\services\report_sync_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/core/models/draft_report_model.dart';
//import 'package:frontend_flutter/core/models/report_model.dart';
import 'package:frontend_flutter/core/services/report_service.dart';

class ReportSyncService {
  static Future<void> syncReadyReports() async {
    debugPrint('🔄 SYNC STARTED');
    final db = FirebaseFirestore.instance;

    final snapshot =
        await db
            .collection('draft_reports')
            .where('sync_state', isEqualTo: 'dirty')
            .get();

    debugPrint('📦 Drafts gefunden: ${snapshot.docs.length}');

    for (final doc in snapshot.docs) {
      debugPrint('➡️ Sync Draft ${doc.id}');
      try {
        final data = doc.data();

        final report = DraftReport(
          uuid: data['uuid'],
          titel: data['titel'],
          beschreibung: data['beschreibung'],
          datum: DateTime.parse(data['datum']),
          anlageId: data['anlage_id'],
          lastModified: DateTime.now(),
          syncState: 'dirty'
        );

        await ReportService.syncReport(report);
        debugPrint('✅ Sync OK für ${doc.id}');

        await doc.reference.update({
          'sync_state': 'synced',
          'synced': true,
          'synced_at': FieldValue.serverTimestamp(),
        });
      } catch (e) {
        debugPrint('❌ Sync FEHLER für ${doc.id}: $e');
        await doc.reference.update({
          'sync_state': 'error',
          'last_error': e.toString(),
        });
      }
    }
  }
}
