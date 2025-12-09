// zentrale Route-Konfiguration
import 'package:flutter/material.dart';
import 'package:frontend_flutter/routes/home/home_screen.dart';
import 'package:frontend_flutter/routes/report/createReport_screen.dart';
import 'package:frontend_flutter/routes/report/reports_screen.dart';
import 'package:frontend_flutter/routes/report/reportDetail_screen.dart';
import 'package:frontend_flutter/routes/profile/profile_screen.dart';
import 'package:frontend_flutter/routes/report/dataUpload_screen.dart';

class AppRoutes {
  static const home = '/home';
  static const upload = '/upload';
  static const reports = '/reports';
  static const reportDetail = '/report_detail';
  static const profile = '/profile';
  static const createReport = '/create_report';
  

  static Map<String, WidgetBuilder> routes = {
    home: (_) => const HomeScreen(),
    reports: (_) => const ReportsOverviewScreen(),
    profile: (_) => const ProfileScreen(),
    createReport: (_) => const CreateReportScreen(),

    reportDetail: (context) {
      // Holt die übergebenen Argumente aus der aktuellen Route
      final args = ModalRoute.of(context)?.settings.arguments;
      // ausgeben der Argumente in KOnsole (Debug-Ausgabe)
      debugPrint('Argumente: $args');

      // Prüft, ob die Argumente eine Map mit einem gültigen "(Report)id"-Wert sind
      if (args is Map<String, dynamic> && args['id'] != null) {
        // Wenn ja, wird der ReportDetailScreen mit der ID des Berichts geöffnet
        return ReportDetailScreen(reportId: args['id'] as int);
      }
      // Falls keine oder fehlerhafte Argumente übergeben wurden 
      // wird Fehlermeldung ausgegeben
      return const Scaffold(body: Center(child: Text("Ungültiger Bericht")));
    },

    upload: (context) {
      // Argumente der Route speichern
      final args = ModalRoute.of(context)?.settings.arguments;
      // prüfen ob güötige Report-Id vorhanden
      if (args is Map<String, dynamic> && args['reportId'] != null) {
        // wenn ja, dann Datauploadscreen mit id des Berichts anzeigen
        return DataUploadScreen(reportId: args['reportId'] as int);
      }
      // sonst fehlermeldung
      return const Scaffold(body: Center(child: Text("Ungültiger Bericht")));
    },
    
    //ModalRoute.of(context)?.settings.arguments greift auf die Daten zu, die beim Navigieren mit Navigator.pushNamed() übergeben wurden
    //Argumente werden als Map übergeben, z. B. {'id': 5} oder {'reportId': 7}.
    
  };
}
