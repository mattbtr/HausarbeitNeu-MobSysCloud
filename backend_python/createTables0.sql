-- Kunden
CREATE TABLE IF NOT EXISTS public.kunden (
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL
);

-- Standorte
CREATE TABLE IF NOT EXISTS public.standorte (
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    adresse VARCHAR,
    kunde_id INTEGER,
    CONSTRAINT standorte_kunde_id_fkey FOREIGN KEY (kunde_id) REFERENCES public.kunden(id) ON UPDATE NO ACTION ON DELETE CASCADE
);

-- Abteilungen
CREATE TABLE IF NOT EXISTS public.abteilungen (
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    standort_id INTEGER,
    CONSTRAINT abteilungen_standort_id_fkey FOREIGN KEY (standort_id) REFERENCES public.standorte(id) ON UPDATE NO ACTION ON DELETE CASCADE
);

-- Anlagen
CREATE TABLE IF NOT EXISTS public.anlagen (
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    abteilung_id INTEGER,
    CONSTRAINT anlagen_abteilung_id_fkey FOREIGN KEY (abteilung_id) REFERENCES public.abteilungen(id) ON UPDATE NO ACTION ON DELETE CASCADE
);

-- Berichte
CREATE TABLE IF NOT EXISTS public.berichte (
    id SERIAL PRIMARY KEY,
    titel VARCHAR NOT NULL,
    beschreibung TEXT NOT NULL,
    erstellt_am TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
    anlage_id INTEGER NOT NULL,
    firebase_uid VARCHAR,
    nutzer_name VARCHAR,
    nutzer_email VARCHAR,
    CONSTRAINT berichte_anlage_id_fkey FOREIGN KEY (anlage_id) REFERENCES public.anlagen(id) ON UPDATE NO ACTION ON DELETE NO ACTION
);

-- Eintraege
CREATE TABLE IF NOT EXISTS public.eintraege (
    id SERIAL PRIMARY KEY,
    titel VARCHAR NOT NULL,
    beschreibung TEXT,
    wert VARCHAR,
    erstellt_am TIMESTAMP WITH TIME ZONE DEFAULT now(),
    bericht_id INTEGER NOT NULL,
    CONSTRAINT eintraege_bericht_id_fkey FOREIGN KEY (bericht_id) REFERENCES public.berichte(id) ON UPDATE NO ACTION ON DELETE CASCADE
);
