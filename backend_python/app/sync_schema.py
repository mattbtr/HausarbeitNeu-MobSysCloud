# app/sync_schema.py
from pydantic import BaseModel
from datetime import datetime
from typing import Optional, List
from uuid import UUID


class EintragSync(BaseModel):
    titel: str
    beschreibung: Optional[str] = None
    wert: Optional[str] = None


class BerichtSync(BaseModel):
    uuid: UUID
    titel: str
    beschreibung: str
    anlage_id: int

    zuletzt_geändert_am: datetime

    firebase_uid: Optional[str] = None
    nutzer_name: Optional[str] = None
    nutzer_email: Optional[str] = None

    eintraege: List[EintragSync] = []
