{% docs stg__customer__model %}
# stg__customer

Dieses Modell ist die **Staging-Sicht** auf Kundenstammdaten im TPC-H-Workshop und dient als standardisierte Eingangsschicht für alle nachgelagerten Modelle.

## Herkunft der Daten
- Fachliche Rohquelle: `source('tpch', 'customer_tpch')` aus dem TPCH-Datensatz.
- Technische Pipeline im Projekt: Die Quelle wird über `snap__customer` historisiert (SCD2) und anschließend in `stg__customer` typisiert und umbenannt.

## Kurzbeschreibung der relevanten Raw Tables (TPCH)
| Raw Table | Inhalt | Relevanz für `stg__customer` |
|---|---|---|
| `customer_tpch` | Kundenstammdaten wie Kunde, Segment, Nation, Adresse, Kontakt, Kontostand | Primäre fachliche Quelle |
| `orders_tpch` | Bestellkopf-Daten mit Kundenbezug | Nachgelagert für Facts/Marts |
| `lineitem_tpch` | Bestellpositionen auf Zeilenebene | Nachgelagert für Detail-Facts |
| `nation_tpch` | Länder-/Nationszuordnung | Für geografischen Kontext im Core |
| `region_tpch` | Regionale Zuordnung | Für roll-up auf Regionsebene |

> Ziel im Staging: **robuste Datentypen, konsistente Spaltennamen und klare Semantik** für den Core-Layer.

## Transformationsprinzipien
1. Technische Typisierung mit `CAST`.
2. Vereinheitlichung der Feldnamen.
3. Bereitstellung eines stabilen Interfaces für `dim__customer`.

Mehr zum TPCH-Hintergrund: [TPC-H Benchmark Overview](https://www.tpc.org/tpch/).
{% enddocs %}