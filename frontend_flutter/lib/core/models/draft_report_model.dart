// Model für Firebase (Oflline Erstellung Report)
class DraftReport {
  final String uuid;
  final String titel;
  final String beschreibung;
  final DateTime datum;
  final int anlageId;

  final DateTime lastModified;
  final String syncState; // dirty | syncing | synced | error

  DraftReport({
    required this.uuid,
    required this.titel,
    required this.beschreibung,
    required this.datum,
    required this.anlageId,
    required this.lastModified,
    required this.syncState,
  });

  Map<String, dynamic> toFirestore() => {
    'uuid': uuid,
    'titel': titel,
    'beschreibung': beschreibung,
    'datum': datum.toIso8601String(),
    'anlage_id': anlageId,
    'last_modified': lastModified.toIso8601String(),
    'sync_state': syncState,
    'synced': syncState == 'synced',
  };

  factory DraftReport.fromFirestore(Map<String, dynamic> json) {
    return DraftReport(
      uuid: json['uuid'],
      titel: json['titel'],
      beschreibung: json['beschreibung'],
      datum: DateTime.parse(json['datum']),
      anlageId: json['anlage_id'],
      lastModified: DateTime.parse(json['last_modified']),
      syncState: json['sync_state'],
    );
  }
}
