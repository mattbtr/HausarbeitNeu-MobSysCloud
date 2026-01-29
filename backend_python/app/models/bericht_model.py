# app/models/bericht_model.py
from sqlalchemy import Column, Integer, String, Text, ForeignKey, DateTime
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.database import Base
from sqlalchemy.dialects.postgresql import UUID
import uuid


class Bericht(Base):
    __tablename__ = 'berichte'

    id = Column(Integer, primary_key=True, index=True)
    uuid = Column(UUID(as_uuid=True), default=uuid.uuid4, unique=True, nullable=False)

    titel = Column(String, nullable=False)
    beschreibung = Column(Text, nullable=False)

    erstellt_am = Column(DateTime(timezone=True), server_default=func.now(), nullable=False)
    zuletzt_geaendert_am = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now(), nullable=False)
    sync_state = Column(String, nullable=False, default="synced") # synced | dirty

    # Verknüpfung zur Anlage (Pflicht)
    anlage_id = Column(Integer, ForeignKey('anlagen.id'), nullable=False)
    anlage = relationship("Anlage", back_populates="berichte")

    # Firebase-User-Infos (optional aber empfohlen)
    firebase_uid = Column(String, nullable=True)
    nutzer_name = Column(String, nullable=True)
    nutzer_email = Column(String, nullable=True)

    # Liste von Einträgen zum Bericht z.b auch Bilder
    eintraege = relationship("Eintrag", back_populates="bericht", cascade="all, delete-orphan")
