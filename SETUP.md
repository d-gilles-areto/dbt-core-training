# Aufsetzen der Schulungsumgebung

Diese Anleitung beschreibt das Setup für den dbt Core Workshop.

In vielen Kundenumgebungen ist das Laden lokaler CSVs in die zentrale Datenbank nicht erlaubt.
Ist dies der Fall, sollte das IT-Team die Dateien aus `./dbt_project/seeds/` in ein Schema (z. B. `sources`) laden.

> Für einen reibungslosen Workshop sollte das Setup vorab vollständig getestet sein.

## 1) PostgreSQL bereitstellen

### Option A: Lokal installiert (Teilnehmer-Setup)
- Download: https://www.postgresql.org/download/
- Empfohlene Workshop-Parameter:
  - Port: `5432`
  - User: `postgres`
  - Passwort: `admin`
  - Database: `workshop` (manuell anlegen nach Installation)

> Hinweis: Bei abweichendem Port die Werte im `profiles.yml` anpassen.

### Option B: Docker (Entwickler & Testing)

```bash
cd postgres_container
docker compose up -d
```

Die Docker-Umgebung erstellt automatisch:
- Database: `workshop`
- Schema: `sources` (für Seeds)
- Container-Name: `dbt_workshop_postgres`

Stoppen:

```bash
cd postgres_container
docker compose down
```

## 2) DBeaver verbinden (optional, empfohlen)

Download: https://dbeaver.io/download/

- Host: `localhost`
- Port: `5432`
- Database: `workshop`
- User: `postgres`
- Password: `admin`

## 3) dbt installieren (pro Betriebssystem)

Voraussetzung: Python 3.10+ (empfohlen 3.11 oder 3.12)

> **Hinweis:** Python 3.12+ erfordert dbt-postgres >= 1.9.0 (ältere Versionen haben Kompatibilitätsprobleme)

Alle Befehle im Repo-Root ausführen (nicht im Unterordner `dbt_project`).

### Windows (PowerShell)

```powershell
py -3.11 -m venv .venv
. .venv/Scripts/activate
pip install -r requirements.txt
cd dbt_project
dbt deps
```

### macOS (zsh/bash)

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
cd dbt_project
dbt deps
```

Wenn `python3` fehlt, vorher installieren (Beispiel Homebrew):

```bash
brew install python@3.11
```

### Linux (bash)

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
cd dbt_project
dbt deps
```

## 4) dbt Profil anlegen (`profiles.yml`)

Standardpfade:
- Windows: `C:\Users\<User>\.dbt\profiles.yml`
- macOS/Linux: `~/.dbt/profiles.yml`

Template:

```yaml
dbt_project:
  outputs:
    sources:
      dbname: workshop
      host: localhost
      pass: admin
      port: 5432
      schema: sources
      threads: 1
      type: postgres
      user: postgres
    dev:
      dbname: workshop
      host: localhost
      pass: admin
      port: 5432
      schema: dev
      threads: 1
      type: postgres
      user: postgres
  target: dev
```

- Der Profilname `dbt_project` muss zum `profile:`-Eintrag in `dbt_project/dbt_project.yml` passen.
- `target: sources` nur für das einmalige Seed-Loading verwenden.

## 5) Verbindung testen

```bash
cd dbt_project
dbt debug
```

## 6) TPCH-Daten laden

Einmalig Seeds ins `sources`-Schema laden:

```bash
dbt seed --target sources
```

Danach regulär im Entwicklungs-Target arbeiten:

```bash
dbt run
dbt test
```


