{% docs mart__orders_per_customer__model %}
# mart__orders_per_customer

Dieser Mart aggregiert Bestellungen auf **Kundenebene** und liefert eine sofort nutzbare Kennzahl für Dashboards und Ad-hoc-Analysen.

## Inhalt
- Join zwischen `fact__orders` und `dim__customer`.
- Aggregation über `COUNT(*)` zu `total_orders`.
- Gruppierung nach Kunde und Segment.

## Ergebnisstruktur
| Feld | Typische Nutzung |
|---|---|
| `customer_id` | Eindeutige Zuordnung im Reporting |
| `customer_name` | Lesbarkeit in Tabellen/Visuals |
| `market_segment` | Segmentvergleiche |
| `total_orders` | KPI: Bestellvolumen je Kunde |

## Typische Analysefragen
1. Welche Kunden haben das höchste Bestellvolumen?
2. Wie verteilt sich das Bestellverhalten nach Segment?
3. Wo entstehen Ausreißer oder potenzielle Datenqualitätsprobleme?

**Hinweis:** Die Mart-Logik ist bewusst transparent gehalten, um den Übergang von Core-Modellen zu konsumierbaren Datenprodukten im Workshop zu demonstrieren.
{% enddocs %}
