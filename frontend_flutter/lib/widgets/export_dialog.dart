import 'package:flutter/material.dart';
import 'package:frontend_flutter/core/services/pdf_export_service.dart'; // enthält die Funktionen zum PDF-Export und E-Mail-Versand

class ExportDialog extends StatelessWidget {
  final int reportId;

  const ExportDialog({super.key, required this.reportId});  // übergeben des Report-Id zur Kennzeichnung welcher Bericht exportiert werden soll

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.picture_as_pdf),
            title: const Text('Als PDF exportieren'),
            onTap: () async {
              Navigator.pop(context);   // Schließt den Dialog, ruft PdfExportService.exportAsPDF(reportId) auf aus pdfExport_service.dart
              await PdfExportService.exportAsPDF(
                reportId,
                onError:
                    (msg) => ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(msg))),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Als PDF exportieren & per E-Mail senden'),
            onTap: () async {
              Navigator.pop(context);   // ruft exportAndSendEmail(reportId) auf aus pdfExport_service.dart

              await PdfExportService.exportAndSendEmail(
                reportId,
                context: context,
                onError:
                    (msg) => ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(msg))),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.cancel),
            title: const Text('Abbrechen'),
            onTap: () => Navigator.pop(context),    // Schließt den export-Dialog.
          ),
        ],
      ),
    );
  }
}