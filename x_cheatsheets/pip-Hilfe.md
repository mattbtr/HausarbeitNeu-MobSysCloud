# pip Cheatsheet – Wichtige Befehle

| Zweck                     | Befehl                             |
|---------------------------|----------------------------------|
| Paket installieren        | `pip install paketname`           |
| Bestimmte Version         | `pip install paketname==1.2.3`    |
| Paket aktualisieren       | `pip install --upgrade paketname` |
| Paket deinstallieren      | `pip uninstall paketname`          |
| Installierte Pakete zeigen| `pip list`                        |
| Paketinfo anzeigen        | `pip show paketname`              |
| Alle Pakete versionieren  | `pip freeze`                     |
| Paketliste speichern      | `pip freeze > requirements.txt`  |
| Pakete aus Liste installieren | `pip install -r requirements.txt` |
| pip selbst aktualisieren  | `pip install --upgrade pip`       |
| Hilfe anzeigen            | `pip help` oder `pip <befehl> --help` |

## Zusatz-Tipps

- Alle Pakete auf neueste Version bringen:

pip list --outdated

pip install --upgrade <paketname>

- Nur für aktuellen User installieren:

pip install paketname --user
