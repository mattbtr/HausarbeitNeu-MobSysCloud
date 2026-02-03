# Installationsanleitung – Kundendokumentation-Builder

Diese Anleitung beschreibt Schritt für Schritt, wie das Projekt **Kundendokumentation-Builder mit Bild- und Daten-Upload** lokal installiert und gestartet werden kann. Die Anleitung richtet sich an Prüfer:innen und technisch versierte Nutzer:innen und setzt keine projektspezifischen Vorkenntnisse voraus.

---

## 1. Voraussetzungen

Für den Betrieb der Anwendung werden folgende Komponenten benötigt:

### Software

- **Git** (zum Klonen des Repositories)
- **Docker Desktop** (inkl. Docker Compose)
  - Windows / macOS: Docker Desktop
  - Linux: Docker Engine + Docker Compose Plugin

> Es ist **keine** lokale Installation von Python, PostgreSQL oder Node.js erforderlich, da alle Komponenten containerisiert sind.

---

## 2. Repository klonen

```bash
git clone https://github.com/mattbtr/MobSysUCloud-Hausarbeit.git
cd MobSysUCloud-Hausarbeit
```

---

## 3. Konfiguration über `.env` anpassen

Aus Sicherheitsgründen sind sensible Konfigurationsdaten **nicht** im Repository enthalten.
Man benötigt drei .env dateien. Eine in Stammverzeichnis mit allen Secrets. Eine in frontend mit frontend-secrets und eine im backend-Verzeichnis.

## 4. Firebase-Konfiguration

Die Anwendung nutzt **Firebase Authentication** und **Firestore**.

### 4.1 Firebase-Projekt

- Firebase-Projekt anlegen unter <https://console.firebase.google.com>
- Authentication (E-Mail/Passwort) aktivieren
- Firestore-Datenbank erstellen

### 4.2 Service-Account-Schlüssel

- In Firebase: *Projekt-Einstellungen → Dienstkonten*
- Neuen privaten Schlüssel generieren (JSON-Datei)

Dieser Schlüssel wird **nicht** ins Repository gelegt, sondern lokal verwendet bzw. in CI/CD als Secret hinterlegt.

---

## 5. Start der Anwendung

Die komplette Anwendung (Backend + Datenbank) wird über Docker Compose gestartet.

```bash
docker compose up --build
```

Beim ersten Start passiert automatisch:

- Initialisierung der PostgreSQL-Datenbank
- Anlegen aller Tabellen über SQL-Skripte
- Start des FastAPI-Backends mit Gunicorn

---

## 6. Erreichbarkeit der Dienste

Nach erfolgreichem Start sind folgende Dienste verfügbar:

- **Backend (FastAPI)**: <http://localhost:8000>
- **API-Dokumentation (Swagger UI)**: <http://localhost:8000/docs>
- **PostgreSQL**: intern über Docker-Netzwerk (`db:5432`)

---

## 7. Erstbefüllung der Datenbank

Optional können Test- bzw. Stammdaten eingespielt werden:

```bash
docker exec -it backend_python python -m app.seed_data
```

Dies legt Beispielkunden, Standorte, Abteilungen und Anlagen an.

---

## 8. Flutter-Frontend (optional)

Das Frontend wurde mit **Flutter** entwickelt und kann unabhängig vom Backend gestartet werden.

Voraussetzungen:

- Flutter SDK
- Android Studio / VS Code

```bash
cd frontend
flutter pub get
flutter run
```

Die API-Basis-URL ist auf `http://localhost:8000` konfiguriert.

---

## 9. Beenden der Anwendung

```bash
docker compose down
```

Optional inkl. Volumes (löscht Datenbank):

```bash
docker compose down -v
```

---

## 10. Hinweise zur Sicherheit

- Zugangsdaten und Secrets sind bewusst ausgelagert
- `.env` und Firebase-Schlüssel sind nicht Teil des Repositories
- Für Produktivbetrieb wären zusätzliche Maßnahmen notwendig (z. B. HTTPS, Secret-Management, Auth-Härtung)

---