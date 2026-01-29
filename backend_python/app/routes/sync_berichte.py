# app/routes/sync_berichte.py
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database import get_db
from app.sync_schema import BerichtSync
from app.services.sync_service import sync_bericht
from app.firebase_auth import get_current_user

router = APIRouter(prefix="/sync", tags=["Sync"])


@router.post("/berichte")
def sync_bericht_endpoint(
    payload: BerichtSync,
    db: Session = Depends(get_db),
    user: dict = Depends(get_current_user),
):
    # Sicherheit: UID erzwingen
    payload.firebase_uid = user["uid"]
    payload.nutzer_email = user.get("email")
    payload.nutzer_name = user.get("name")
    
    try:
        bericht = sync_bericht(db, payload)
        return {
            "status": "synced",
            "bericht_id": bericht.id,
            "uuid": str(bericht.uuid),
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
