#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE TABLE IF NOT EXISTS settlement
    (
        id SERIAL,
        owner character varying(128) NOT NULL,
        name character varying(50) COLLATE pg_catalog."default" NOT NULL,
        survival_limit smallint DEFAULT 0,
        departing_survival smallint DEFAULT 0,
        collective_cognition smallint DEFAULT 0,
        year smallint DEFAULT 0,
        CONSTRAINT settlement_pkey PRIMARY KEY (id)
    );

    CREATE TABLE IF NOT EXISTS survivor
    (
        id SERIAL,
        settlement integer NOT NULL,
        name character varying(50) COLLATE pg_catalog."default" NOT NULL,
        birth smallint NOT NULL DEFAULT 0,
        huntxp smallint NOT NULL DEFAULT 0,
        survival smallint NOT NULL DEFAULT 1,
        movement smallint NOT NULL DEFAULT 5,
        accuracy smallint NOT NULL DEFAULT 0,
        strength smallint NOT NULL DEFAULT 0,
        evasion smallint NOT NULL DEFAULT 0,
        luck smallint NOT NULL DEFAULT 0,
        speed smallint NOT NULL DEFAULT 0,
        insanity smallint NOT NULL DEFAULT 0,
        systemic_pressure smallint NOT NULL DEFAULT 0,
        torment smallint NOT NULL DEFAULT 0,
        lumi smallint NOT NULL DEFAULT 0,
        gender character(1) COLLATE pg_catalog."default",
        CONSTRAINT survivor_pkey PRIMARY KEY (id),
        CONSTRAINT fk_settlement_id 
            FOREIGN KEY (settlement)
                REFERENCES settlement (id)
                ON DELETE CASCADE
    );

    CREATE USER appuser WITH PASSWORD '$APPUSER_PASS';
    GRANT USAGE ON SCHEMA public TO appuser;
    GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO appuser;
    GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO appuser;
EOSQL