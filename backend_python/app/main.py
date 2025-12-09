from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
import os
from app.database import engine
from app import models
#from app.firebase_auth import firebase_auth_setup
from app.routes import kunden, standorte, abteilungen, anlagen, berichte

# erstellt Tabellen anhand Models --> auskommentiert, da Tabellen bereits mit sql angelegt zuvor
# models.Base.metadata.create_all(bind=engine)

# initialisieren der FastAPI-app
app = FastAPI()

# Verzeichnis für Datei-Uploads
UPLOAD_DIR = "uploads"
os.makedirs(UPLOAD_DIR, exist_ok=True)

# Mount für Uploads, damit zugegriffen werden kann auf Uploads --> statische DAteien die weiter bestehen nach Backend beendet wird.
app.mount("/uploads", StaticFiles(directory=UPLOAD_DIR), name="uploads")

# Standard-Route --> fehlerbehandlung
@app.get("/")
def root():
    return {"msg": "Backend läuft!"}


# Einbinden aller anderen Routen des Backends
app.include_router(kunden.router)
app.include_router(standorte.router)
app.include_router(abteilungen.router)
app.include_router(anlagen.router)
app.include_router(berichte.router)
#app.include_router(eintrag.router)


# Backend starten mit:
    # uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
# oder
    # uvicorn app.main:app --host 192.168.0.108 --port 8000 --reload

