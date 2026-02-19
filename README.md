# dbt Core Workshop

Dieses Repository enthält die Materialien für eine **dbt Core** Schulung (auf PostgreSQL).
Wir arbeiten mit einem reduzierten TPCH‑Datensatz und bauen Schritt für Schritt ein kleines dbt Projekt auf.
Der Workshop ist so konzipiert, dass Theorie-Blöcke jeweils direkt durch praktische Übungen ergänzt werden und die Übungen aufeinander aufbauen, sodass am Ende ein vollständiger Mini-Use-Case umgesetzt ist.

**Workshop-Format:** 2 Tage, 15 aufeinander aufbauende Exercises (Ex 00 – Ex 14)

Die für die Schulung relevanten Daten befinden sich ebenfalls in diesem Repository unter `./dbt_project/seeds/`.


## Inhalte und Bestandteile

- **dbt Schulungsprojekt** - (`./dbt_project/`)
  - 13 dbt Models (Staging, Core Dimensions/Facts, Marts)
  - 27 Data Tests (generic, singular, custom generic)
  - 1 Snapshot (SCD Type 2)
  - Incremental Models mit Merge-Strategy
  - Vollständige YAML-Dokumentation
- **Schulungsdaten** - (`./dbt_project/seeds/`)
  - 8 TPCH Tabellen (Scale Factor 0.1, ~866k Rows)
- **Docker PostgreSQL Setup** - (`./postgres_container/`)
- **Setup-Anleitung** - ([SETUP.md](/SETUP.md))
- **Exercise-Struktur** - siehe Workshop-Dokumentation


## Requirements

Voraussetzungen für die Durchführung:
- Python 3.10+ (empfohlen 3.11 oder 3.12)
  - **Hinweis:** Python 3.12+ erfordert dbt-postgres >= 1.9.0
- dbt Core mit PostgreSQL-Adapter (Installation siehe Setup)
- Zugriff auf eine PostgreSQL-Datenbank (lokal oder zentral) inkl. Berechtigungen zum Anlegen von Schemata und Objekten
  - Empfohlene DB: `workshop`
- VS Code (empfohlen)
- DBeaver (optional, für DB-Exploration) 


## Quickstart

1. Repository klonen
2. Setup durchführen: siehe [SETUP.md](/SETUP.md)
3. dbt Projekt öffnen und Verbindung prüfen (`dbt debug`)
4. Seeds laden (`dbt seed --target sources`) und Workshop starten

## Workshop-Architektur

Das finale Modell umfasst folgende Komponenten:

**Schemas:**
- `sources` - TPCH Seeds (8 Tabellen)
- `dev_staging` - Staging Views (5 Models)
- `dev_core` - Dimensions & Facts (4 Models, inkl. 2 Incremental)
- `dev_marts` - Business Marts (4 Models)
- `snapshots` - SCD Type 2 Snapshots (1 Model)

**Testing:**
- 27 Data Tests (unique, not_null, relationships, accepted_values, custom generic tests)

**Key Features:**
- Incremental Models mit `merge` Strategy
- Custom Generic Tests
- SCD Type 2 Snapshots mit `check` Strategy
- Konforme Dimensionen (dim__geo)
- Multi-Grain Facts (order_lines, orders)



