# app/database.py
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base
import os
from dotenv import load_dotenv

# laden der Umgebungsvariablen von .env
load_dotenv()

# speichern der datenbank-url in Variable
DATABASE_URL = os.getenv("DATABASE_URL")

# SqlAlchemy Engine mit datenbank-url erzeugen
engine = create_engine(DATABASE_URL)
# Session-Klasse, die Datenbank-Transaktionen verwaltet
# autoflush und autocommit deaktiviert, damit manuell gesteuert wird, wann geschrieben wird
SessionLocal = sessionmaker(bind=engine, autoflush=False, autocommit=False)
# Basisklasse für alle ORM-Modelle --> Models repräsentieren Tabellen in SQLAlchemy
Base = declarative_base()

# Hier die get_db Funktion hinzufügen:
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
