# __init__.py = spezielle Python-Datei, die ein Verzeichnis als Python-Paket kennzeichnet.
# Vorteil: 
    # macht aus einem Verzeichnis ein importierbares Python-Paket.
    # Code innerhalb von __init__.py wird ausgeführt, wenn das Paket importiert wird

# Beispiel:
    # from app.models import Kunde 
# schreiben, ohne explizit app.models.kunde zu importieren.
# --> viele Einzelimporte könnnen gebündelt werden

from .kunde_model import Kunde
from .standort_model import Standort
from .abteilung_model import Abteilung
from .anlage_model import Anlage
from .bericht_model import Bericht
from .eintrag_model import Eintrag
#from .user import User
