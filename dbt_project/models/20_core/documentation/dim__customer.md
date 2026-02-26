{% docs dim__customer__model %}
# dim__customer

`dim__customer` bildet die **Kundendimension** für analytische Auswertungen und stellt die kundenbezogenen Attribute in konsistenter Business-Semantik bereit.

## Zweck im Datenmodell
- Eine Zeile pro Kunde (Dimensionseintrag).
- Harmonisierung von Attributen für Reporting und Self-Service.
- Grundlage für Joins mit Facts und Marts.

## Semantische Kernfelder
| Feld | Bedeutung |
|---|---|
| `customer_id` | Stabiler Business Key für Kundenanalysen |
| `customer_name` | Lesbarer Kundenname für Reports |
| `market_segment` | Segmentierung (z. B. Automobil, Building) |
| `nation_id` | Schlüssel für geografische Anreicherung |

## Einordnung im Layer-Modell
`stg__customer` → **`dim__customer`** → `mart__orders_per_customer`

Diese Dimension ist bewusst schlank gehalten, damit sie in Übungen einfach erweitert werden kann (z. B. weitere Hierarchien, Slowly Changing Attributes, Data Quality Regeln).
{% enddocs %}
