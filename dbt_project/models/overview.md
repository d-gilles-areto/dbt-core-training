{% docs __overview__ %}
# dbt Core Workshop – Überblick

![areto group Logo](assets/areto_logo.png)

Willkommen zur Schulungsdokumentation des Projekts **dbt_project**. Diese Docs-Seite begleitet den Workshop von den Rohdaten bis zu konsumierbaren Marts.

## Ziel der Schulung
- Verständnis einer **layered dbt-Architektur**.
- Saubere Trennung von Staging, Core und Mart.
- Praktische Umsetzung von Dokumentation, Tests und nachvollziehbaren Transformationen.

## Projektstruktur (High Level)
| Layer | Namenskonvention | Hauptzweck |
|---|---|---|
| `00_sources` | `source(...)` | Definition der TPCH-Quellen |
| `10_staging` | `stg__*` | Typisierung & Standardisierung |
| `20_core` | `dim__*`, `fact__*` | Fachliche Modellierung |
| `30_marts` | `mart__*` | Reporting-nahe Aggregationen |

## So arbeitest du im Workshop
1. Quelle verstehen (`sources`, Seed/Raw-Kontext).
2. Staging-Modelle lesen und erweitern.
3. Core-Modelle für Business-Semantik aufbauen.
4. Marts für konkrete Analysefragen bereitstellen.
5. Qualität über Tests und Dokumentation absichern.

## Orientierung in den Docs
- Nutze den Lineage-Graphen, um Datenflüsse nachzuvollziehen.
- Öffne Modellseiten für SQL, Metadaten und Beschreibungen.
- Verwende diese Overview als Einstiegspunkt für neue Teilnehmer:innen.

Weitere Informationen zu dbt Docs: [Offizielle Dokumentation](https://docs.getdbt.com/docs/build/documentation).
{% enddocs %}
