# Aufsetzen der Schulungsumgebung

Diese Anleitung beschreibt, wie die Schulungsumgebung für den Workshop aufgesetzt werden kann.

In vielen Kundenumgebungen ist das Laden lokaler CSVs in die zentrale Datenbank nicht erlaubt. 
Ist dies der Fall, sollte der Kunde die Dateien aus `./dbt_project/seeds/` selbstständig durch das IT‑Team in ein Schema (z. B. `sources`) laden.

> Damit die Schulung reibungslos verlaufen kann, sollte das Setup bereits im Vorfeld aufgesetzt werden, sodass die Schulung direkt auf dem lauffähigen Setup aufsetzen kann.



## 1) PostgreSQL bereitstellen

### Option A: Lokal installiert (Teilnehmer-Setup)
- Download: https://www.postgresql.org/download/

Empfohlene Setting für den Workshop:
   - **Port:** `5432`
   - **user:** `postgres`
   - **Passwort:** `admin`
   - **Datenbank:** `dbt_workshop`

> Hinweis: Wenn dein PostgreSQL bereits läuft (oder der Port belegt ist), verwende einen freien Port und passe später das dbt-Profil entsprechend an.

### Option B: Docker (Entwickler & Testing)

```bash
$ cd postgres_container
$ docker compose up -d
```

Die Docker-Umgebung erstellt automatisch:
- Database: `dbt_workshop`
- Schema: `sources` (für Seeds)
- Container-Name: `dbt_workshop_postgres`

Stoppen:

```bash
cd postgres_container
docker compose down
```



## 2) DBeaver verbinden (optional, empfohlen)

   Download: https://dbeaver.io/download/

   Verbindung in DBeaver:
      - **Host:** `localhost`
      - **Port:** `5432`
      - **Database:** `dbt_workshop` (oder deine Default-DB)
      - **User:** `postgres`
      - **Password:** `admin`



## 3) dbt installieren (pro Betriebssystem)

Voraussetzung: Python 3.10+ (empfohlen 3.11 oder 3.12)

Wir installieren dbt in einer virtuellen Umgebung. **Führe die folgenden Befehle im Repo-Root aus** (nicht im dbt-Unterordner).

> **Hinweis:** Python 3.12+ erfordert dbt-postgres >= 1.9.0 (ältere Versionen haben Kompatibilitätsprobleme)


Alle Befehle im Repo-Root ausführen (nicht im Unterordner `dbt_project`).

### Windows (PowerShell)

```PowerShell
$ py -3.11 -m venv .venv
$ . .venv/Scripts/activate
$ pip install -r requirements.txt
```

### macOS (zsh/bash)

```bash
$ python3 -m venv .venv
$ source .venv/bin/activate
$ pip install -r requirements.txt
```



## 4) dbt Profil initialisieren (`profiles.yml`)

dbt erwartet ein `profiles.yml` standardmäßig unter `C:\Users\<User>\.dbt\`.

Dies ist ein **Template** für das profile.yml - sollte die lokale PostgreSQL wie oben dargestellt angelegt worden sein, kann das Profil so übernommen werden.

```yaml
dbt_project:
   outputs:
      sources: # <-- Bitte nicht verändern
         dbname: dbt_workshop
         host: localhost
         pass: admin
         port: 5432
         schema: sources   # <-- Bitte nicht verändern
         threads: 1
         type: postgres
         user: postgres
      dev:  # <-- Bitte nicht verändern
         dbname: dbt_workshop
         host: localhost
         pass: admin
         port: 5432
         schema: sotte  # <-- Developer Präfix hier einsetzen
         threads: 1
         type: postgres
         user: postgres
   target: dev # <-- Bitte nicht verändern
```

> Hinweis: In dem Profil `dev:` sollte unter `schema:` ein individueller Developer-Kürzel eingetragen werden.

> Hinweis: Wie unter `target` konfiguriert, ist das Standard-Target `dev`. Es wird ein weiteres `target: sources` spezifiziert - dieses wird ausschließlich zum Einmaligen Laden der Workshop-Daten benötigt.



## 5) Das dbt Projekt öffnen

```PowerShell
$ cd .\dbt_project\
```


## 6.) Verbindung testen

```PowerShell
$ dbt debug
```



## 7) TPCH-Daten für die Schulung laden

Für die Schulung wird ein TPCH-Datenmodell benutzt. Um das interagieren und Analysieren der Daten für die Teilnehmenden zu vereinfachen, wurden die Datensätze reduziert.

Die benötigten Daten sind bereits in diesem Repository unter ./seeds/ eingebunden und können direkt angelegt und geladen werden. Für das einmalige Laden der .csv Dateien wird das im profiles.yml definierte target sources benutzt.

```PowerShell
$ dbt seed --target sources
```

