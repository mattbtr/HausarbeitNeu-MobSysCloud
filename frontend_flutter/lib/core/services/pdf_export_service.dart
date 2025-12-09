import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class PdfExportService {

  // 1. Option: Exportieren des Berichts in eine PDF mit 
  /// Lädt das PDF für den gegebenen Report vom Backend und öffnet es.
  static Future<void> exportAsPDF(
    int reportId, {
    Function(String)? onError,
  }) async {
    // Backend-Endpunkt, der das PDF generiert und zurückgibt aus berichte.py
    final url =
        'http://192.168.0.108:8000/berichte/$reportId/export/pdf';
    try {
      // GET-Request aus, um das PDF vom Server zu laden
      final response = await http.get(Uri.parse(url));

      // wenn anfrage erfolgreich:
      if (response.statusCode == 200) {
        // Temporären Speicherort im Gerät abrufen
        final dir = await getTemporaryDirectory();
        // Temporäre PDF-Datei im Zwischenspeicher anlegen
        final file = File('${dir.path}/bericht_$reportId.pdf');
        // Die empfangenen PDF-Daten in die Datei schreiben
        await file.writeAsBytes(response.bodyBytes);
        // Datei automatisch mit der Standard-pdf-App öffnen
        await OpenFile.open(file.path);

      } else {
        onError?.call('Fehler beim PDF-Export: ${response.statusCode}');
      }
    } catch (e) {
      onError?.call('Fehler beim PDF-Export: $e');
    }
  }

  // 2. Option: Exportieren des Berichts in eine PDF und anschließendes Versenden als Anhang in einer Mail
  static Future<void> exportAndSendEmail(
    int reportId, {
    required BuildContext context,
    Function(String)? onError,
  }) async {
    // 1. Empfänger-Adresse abfragen in einem Dialog (AlertDialog)
    final emailController = TextEditingController();
    final recipient = await showDialog<String>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Empfänger-E-Mail eingeben'),
            content: TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: 'z.B. max@kunde.de'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),  // Abbruch Button 
                child: const Text('Abbrechen'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, emailController.text),  // Senden Button mit Übergabe der Empfänger-Mail-adresse
                child: const Text('Senden'),
              ),
            ],
          ),
    );

    // Wenn der Nutzer abbricht oder nichts eingibt
    if (recipient == null || recipient.isEmpty) {
      if (context.mounted) {
        onError?.call('E-Mail-Versand abgebrochen.');
      }
      return;
    }

    // 2. Request an Backend senden

    // Endpunkt aus berichte.py
    final url = 'http://192.168.0.108:8000/berichte/$reportId/export/email';
    
    try {
      // post-Request zum Senden der Email-Adresse an Backend-Endpunkt im json-format
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'recipient': recipient}),   // / Empfängeradresse im Body versenden
      );

      // Bei erfolgreichem Versand Rückmeldung an den Nutzer
      if (response.statusCode == 200) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('E-Mail wurde versendet!')),
          );
        }
      }
      // Wenn das Backend mit einem Fehler antwortet
       else {
        if (context.mounted) {
          onError?.call('Fehler beim E-Mail-Export: ${response.body}');
        }
      }
    }
    // Wenn beim Senden ein Fehler auftritt
     catch (e) {
      if (context.mounted) {
        onError?.call('Fehler beim E-Mail-Export: $e');
      }
    }
  }
}
