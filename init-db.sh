#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE SCHEMA IF NOT EXISTS campaign;
    CREATE TABLE IF NOT EXISTS campaign.settlement
    (
        id SERIAL,
        owner character varying(50) NOT NULL,
        name character varying(50) COLLATE pg_catalog."default" NOT NULL,
        survival_limit smallint DEFAULT 0,
        departing_survival smallint DEFAULT 0,
        collective_cognition smallint DEFAULT 0,
        year smallint DEFAULT 0,
        CONSTRAINT settlement_pkey PRIMARY KEY (id)
    );
    CREATE TABLE IF NOT EXISTS campaign.survivor
    (
        id SERIAL PRIMARY KEY,
        settlement integer NOT NULL,
        name VARCHAR(50) COLLATE pg_catalog."default" NOT NULL,
        gender character(1) COLLATE pg_catalog."default",
        birth smallint NOT NULL DEFAULT 0,
        huntxp smallint NOT NULL DEFAULT 0,
        survival smallint NOT NULL DEFAULT 1,
        courage smallint NOT NULL DEFAULT 0,
        understanding smallint NOT NULL DEFAULT 0,
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
        status VARCHAR(50),
        UNIQUE (settlement, name),
        CONSTRAINT fk_settlement_id 
            FOREIGN KEY (settlement)
                REFERENCES campaign.settlement (id)
                ON DELETE CASCADE
    );

    CREATE USER app WITH PASSWORD '$APPUSER_PASS';
    GRANT USAGE ON SCHEMA campaign TO app;
    GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA campaign TO app;
    GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA campaign TO app;

EOSQL