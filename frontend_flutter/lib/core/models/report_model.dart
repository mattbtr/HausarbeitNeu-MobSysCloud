// Model für Postgres DB
class Report {
  final int id;
  final String titel;
  final String beschreibung;
  final DateTime datum;
  final int anlageId;

  Report({
    required this.id,
    required this.titel,
    required this.beschreibung,
    required this.datum,
    required this.anlageId,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      titel: json['titel'],
      beschreibung: json['beschreibung'],
      datum: DateTime.parse(json['erstellt_am']),
      anlageId: json['anlage_id'],
    );
  }
}
