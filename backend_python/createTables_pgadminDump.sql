-- Table: public.kunden

-- DROP TABLE IF EXISTS public.kunden;

CREATE TABLE IF NOT EXISTS public.kunden
(
    id SERIAL NOT NULL DEFAULT nextval('kunden_id_seq'::regclass),
    name character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT kunden_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.kunden
    OWNER to postgres;
-- Index: ix_kunden_id

-- DROP INDEX IF EXISTS public.ix_kunden_id;

CREATE INDEX IF NOT EXISTS ix_kunden_id
    ON public.kunden USING btree
    (id ASC NULLS LAST)
    TABLESPACE pg_default;




-- Table: public.standorte

-- DROP TABLE IF EXISTS public.standorte;

CREATE TABLE IF NOT EXISTS public.standorte
(
    id integer NOT NULL DEFAULT nextval('standorte_id_seq'::regclass),
    name character varying COLLATE pg_catalog."default" NOT NULL,
    adresse character varying COLLATE pg_catalog."default",
    kunde_id integer,
    CONSTRAINT standorte_pkey PRIMARY KEY (id),
    CONSTRAINT standorte_kunde_id_fkey FOREIGN KEY (kunde_id)
        REFERENCES public.kunden (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.standorte
    OWNER to postgres;
-- Index: ix_standorte_id

-- DROP INDEX IF EXISTS public.ix_standorte_id;

CREATE INDEX IF NOT EXISTS ix_standorte_id
    ON public.standorte USING btree
    (id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.abteilungen

-- DROP TABLE IF EXISTS public.abteilungen;

CREATE TABLE IF NOT EXISTS public.abteilungen
(
    id integer NOT NULL DEFAULT nextval('abteilungen_id_seq'::regclass),
    name character varying COLLATE pg_catalog."default" NOT NULL,
    standort_id integer,
    CONSTRAINT abteilungen_pkey PRIMARY KEY (id),
    CONSTRAINT abteilungen_standort_id_fkey FOREIGN KEY (standort_id)
        REFERENCES public.standorte (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.abteilungen
    OWNER to postgres;
-- Index: ix_abteilungen_id

-- DROP INDEX IF EXISTS public.ix_abteilungen_id;

CREATE INDEX IF NOT EXISTS ix_abteilungen_id
    ON public.abteilungen USING btree
    (id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.anlagen

-- DROP TABLE IF EXISTS public.anlagen;

CREATE TABLE IF NOT EXISTS public.anlagen
(
    id integer NOT NULL DEFAULT nextval('anlagen_id_seq'::regclass),
    name character varying COLLATE pg_catalog."default" NOT NULL,
    abteilung_id integer,
    CONSTRAINT anlagen_pkey PRIMARY KEY (id),
    CONSTRAINT anlagen_abteilung_id_fkey FOREIGN KEY (abteilung_id)
        REFERENCES public.abteilungen (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.anlagen
    OWNER to postgres;
-- Index: ix_anlagen_id

-- DROP INDEX IF EXISTS public.ix_anlagen_id;

CREATE INDEX IF NOT EXISTS ix_anlagen_id
    ON public.anlagen USING btree
    (id ASC NULLS LAST)
    TABLESPACE pg_default;



-- Table: public.berichte

-- DROP TABLE IF EXISTS public.berichte;

CREATE TABLE IF NOT EXISTS public.berichte
(
    id integer NOT NULL DEFAULT nextval('berichte_id_seq'::regclass),
    titel character varying COLLATE pg_catalog."default" NOT NULL,
    beschreibung text COLLATE pg_catalog."default" NOT NULL,
    erstellt_am timestamp with time zone NOT NULL DEFAULT now(),
    anlage_id integer NOT NULL,
    firebase_uid character varying COLLATE pg_catalog."default",
    nutzer_name character varying COLLATE pg_catalog."default",
    nutzer_email character varying COLLATE pg_catalog."default",
    CONSTRAINT berichte_pkey PRIMARY KEY (id),
    CONSTRAINT berichte_anlage_id_fkey FOREIGN KEY (anlage_id)
        REFERENCES public.anlagen (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.berichte
    OWNER to postgres;
-- Index: ix_berichte_id

-- DROP INDEX IF EXISTS public.ix_berichte_id;

CREATE INDEX IF NOT EXISTS ix_berichte_id
    ON public.berichte USING btree
    (id ASC NULLS LAST)
    TABLESPACE pg_default;



-- Table: public.eintraege

-- DROP TABLE IF EXISTS public.eintraege;

CREATE TABLE IF NOT EXISTS public.eintraege
(
    id integer NOT NULL DEFAULT nextval('eintraege_id_seq'::regclass),
    titel character varying COLLATE pg_catalog."default" NOT NULL,
    beschreibung text COLLATE pg_catalog."default",
    wert character varying COLLATE pg_catalog."default",
    erstellt_am timestamp with time zone DEFAULT now(),
    bericht_id integer NOT NULL,
    CONSTRAINT eintraege_pkey PRIMARY KEY (id),
    CONSTRAINT eintraege_bericht_id_fkey FOREIGN KEY (bericht_id)
        REFERENCES public.berichte (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.eintraege
    OWNER to postgres;
-- Index: ix_eintraege_id

-- DROP INDEX IF EXISTS public.ix_eintraege_id;

CREATE INDEX IF NOT EXISTS ix_eintraege_id
    ON public.eintraege USING btree
    (id ASC NULLS LAST)
    TABLESPACE pg_default;