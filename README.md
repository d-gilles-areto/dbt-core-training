# dbt_core_workshop

1. PostgreSQL installieren

   Download: https://www.postgresql.org/download/

   Empfohlene Setting für den Workshop:
      - **Port:** `5432`
      - **user:** `postgres`
      - **Passwort:** `admin`
   
   > Hinweis: Wenn dein PostgreSQL bereits läuft (oder der Port belegt ist), verwende einen freien Port und passe später das dbt-Profil entsprechend an.

---

2. DBeaver installieren und die PostgreSQL einbinden
   
   Download: https://dbeaver.io/download/

   Verbindung in DBeaver:
      - **Host:** `localhost`
      - **Port:** `5432`
      - **Database:** `postgres` (oder deine Default-DB)
      - **User:** `postgres`
      - **Password:** `admin`

---

3. dbt installieren

   Voraussetzung: Python 3.10+ (empfohlen: 3.10)

   Wir installieren dbt in einer virtuellen Umgebung. **Führe die folgenden Befehle im Repo-Root aus** (nicht im dbt-Unterordner).

   ### Windows (PowerShell)
   ```PowerShell
    $ py -3.10 -m venv .venv
    $ . .venv/Scripts/activate
    $ pip install -r requirements.txt
   ```

---

4. dbt Profil initialisieren (profiles.yml)

   dbt erwartet ein `profiles.yml` standardmäßig unter `C:\Users\<User>\.dbt\`.

   Dies ist ein Template für das profile.yml - sollte die lokale PostgreSQL wie oben dargestellt angelegt worden sein, kann das Profil so übernommen werden.

   ```yaml
   dbt_project:
      outputs:
         sources:
            dbname: postgres
            host: localhost
            pass: admin
            port: 5432
            schema: sources
            threads: 1
            type: postgres
            user: postgres
         dev:
            dbname: postgres
            host: localhost
            pass: admin
            port: 5432
            schema: dev
            threads: 1
            type: postgres
            user: postgres
      target: dev
   ```
   
   &rarr; Der Profilname (hier: `dbt_project`) muss zum `profile:` Eintrag in `dbt_project/dbt_project.yml` passen.

   > Hinweis: `schema:` dev wird in der DB als Schema angelegt und benutzt. Falls ein anderes Schema gewünscht ist, muss der Wert angepasst werden.

   > Hinweis: Wie unter `target` konfiguriert, ist das Standard-Target `dev`. Es wird ein weiteres `target: sources` spezifiziert - dieses wird ausschließlich zum Einmaligen Laden der Daten benötigt.

---

5. Das dbt Projekt öffnen

   ```PowerShell
   $ cd .\dbt_project\
   ```

---

6. Verbindung testen

   ```PowerShell
   $ dbt debug
   ```

---

7. TPCH-Daten für die Schulung laden

   Für die Schulung wird ein TPCH-Datenmodell benutzt.
   Um das interagieren und Analysieren der Daten für die Teilnehmenden zu vereinfachen, wurden die Datensätze reduziert.

   Die benötigten Daten sind bereits in diesem Repository unter `./seeds/` eingebunden und können direkt angelegt und geladen werden.
   Für das einmalige Laden der .csv Dateien wird das im profiles.yml definierte target `sources` benutzt.

   ```PowerShell
   $ dbt seed --target sources
   ```


