# npm Cheatsheet – Wichtige Befehle

| Zweck                              | Befehl                               |
|-----------------------------------|------------------------------------|
| Neues Projekt initialisieren       | `npm init` oder `npm init -y`       |
| Pakete lokal installieren           | `npm install paketname`              |
| Paket global installieren           | `npm install -g paketname`           |
| Alle Abhängigkeiten installieren    | `npm install` (im Projektordner mit package.json) |
| Paket deinstallieren                | `npm uninstall paketname`            |
| Paket aktualisieren                 | `npm update paketname`               |
| Installierte Pakete anzeigen        | `npm list`                         |
| Globale Pakete anzeigen             | `npm list -g --depth=0`              |
| Paketinformationen anzeigen         | `npm view paketname`                 |
| Cache bereinigen                   | `npm cache clean --force`            |
| Skripte aus package.json ausführen | `npm run skriptname`                 |
| Häufige Skripte (ohne run) starten| `npm start`, `npm test`              |
| Paket im npm-Repository suchen     | `npm search suchbegriff`             |
| npm selbst aktualisieren           | `npm install npm@latest -g`          |

## Tipps

- Nutze `npm init -y`, um schnell eine package.json mit Standardwerten zu erstellen.  
- Verwende `npm run` für alle Skripte außer `start` und `test`, die kürzer sind.  
- `npx` erlaubt das Ausführen von Paketen ohne Installation (z.B. `npx create-react-app`).  
- Um globale Pakete zu verwalten, ist das `-g` Flag wichtig.  
- Cache-Probleme löst du mit `npm cache clean --force`.
