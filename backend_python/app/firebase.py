# app/firebase.py
import os
import firebase_admin
from firebase_admin import credentials, auth

def init_firebase():
    if not firebase_admin._apps:
        cred_path = os.getenv("SERVICE_ACCOUNT")
        if not cred_path:
            raise RuntimeError("SERVICE_ACCOUNT not set")

        cred = credentials.Certificate(cred_path)
        firebase_admin.initialize_app(cred)


def verify_firebase_token(token: str) -> dict:
    """
    Verifiziert ein Firebase ID Token und gibt das Decoded Token zurück.
    """
    return auth.verify_id_token(token)
