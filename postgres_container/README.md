# Lokaler PostgreSQL Container (nur Entwickler)

Dieser Container ist ausschließlich für lokales Entwickler-Testing gedacht (nicht für Workshop-Teilnehmer).

## Start

```bash
cd postgres_container
docker compose up -d
```

## Stop

```bash
docker compose down
```

## Persistenz

Die Datenbankdaten werden im Docker-Volume `postgres_data` persistiert.

- Host: `localhost`
- Port: `5432`
- User: `postgres`
- Passwort: `admin`
- DB: `postgres`

Diese Werte sind konsistent mit `SETUP.md` und `profiles.yml`-Template.
