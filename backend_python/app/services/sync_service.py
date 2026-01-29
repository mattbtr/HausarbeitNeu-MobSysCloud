# app/services/sync_service.py
from sqlalchemy.orm import Session
from app.models.bericht_model import Bericht
from app.models.eintrag_model import Eintrag
from app.sync_schema import BerichtSync
from datetime import datetime


def sync_bericht(db: Session, payload: BerichtSync) -> Bericht:
    bericht = (
        db.query(Bericht)
        .filter(Bericht.uuid == payload.uuid)
        .first()
    )

    # 🆕 Neuer Bericht
    if bericht is None:
        bericht = Bericht(
            uuid=payload.uuid,
            titel=payload.titel,
            beschreibung=payload.beschreibung,
            anlage_id=payload.anlage_id,
            zuletzt_geändert_am=payload.zuletzt_geändert_am,
            sync_state="synced",
            firebase_uid=payload.firebase_uid,
            nutzer_name=payload.nutzer_name,
            nutzer_email=payload.nutzer_email,
        )
        db.add(bericht)
        db.flush()  # ID erzeugen

    # 🔄 Bestehender Bericht → Konfliktprüfung
    # Konfliktstrategie: Last write wins (Server bevorzugt)
    else:
        if payload.zuletzt_geändert_am <= bericht.zuletzt_geändert_am:
            # Backend-Version ist neuer → Client verliert
            return bericht

        # Client-Version gewinnt
        bericht.titel = payload.titel
        bericht.beschreibung = payload.beschreibung
        bericht.anlage_id = payload.anlage_id
        bericht.zuletzt_geändert_am = payload.zuletzt_geändert_am
        bericht.sync_state = "synced"

        # Einträge ersetzen (einfach & robust)
        bericht.eintraege.clear()

    # 📎 Einträge neu anlegen
    for e in payload.eintraege:
        eintrag = Eintrag(
            titel=e.titel,
            beschreibung=e.beschreibung,
            wert=e.wert,
            bericht_id=bericht.id,
        )
        db.add(eintrag)

    db.commit()
    db.refresh(bericht)

    return bericht
