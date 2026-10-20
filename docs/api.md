# Wheelhouse API v1

Base path: `/api/v1`. Every response is JSON, errors included. Authentication
uses the header `Authorization: Bearer <token>`.

## Routes

| Verb | Path | Token | Statuses |
|------|------|-------|----------|
| GET  | /api/v1/services     | no  | 200 |
| GET  | /api/v1/services/:id | no  | 200, 404 |
| POST | /api/v1/services     | yes | 201, 400, 401, 422 |
| GET  | /api/v1/repairs      | yes | 200, 400 (unknown `state`), 401 |
| GET  | /api/v1/repairs/:id  | yes | 200, 401, 404 |

`GET /api/v1/repairs?state=<state>` filters by state: received, quoted,
approved, declined, in_progress, ready_for_pickup, returned.

## Documents

Service (same shape in index, show and create):

```json
{ "id": 1, "name": "Brake or gear adjustment", "price": "10000.00", "repairs_count": 3 }
```

Repair:

```json
{
  "id": 7,
  "state": "returned",
  "received_on": "2026-10-08",
  "promised_on": "2026-10-08",
  "returned_on": "2026-10-08",
  "bike": { "brand": "Giant", "model": "Escape 3", "serial_number": "GNT-E3-2023-014" },
  "customer": { "name": "Ana Morales" },
  "lines": [ { "service": "Flat tire repair", "price_charged": "6000.00" } ],
  "total": "6000.00",
  "overdue": false,
  "customer_answer": "approved"
}
```

Collection of repairs (a JSON array, no pages, newest first):

```json
[ { "id": 7, "state": "returned", "...": "same shape as a single repair" } ]
```

Error (400, 401, 404 and 422 share this shape):

```json
{ "errors": ["Name can't be blank", "Price must be greater than 0"] }
```

## Decisions

- **Prices travel as strings** with two decimals (`"10000.00"`) in every
  document. The column is a decimal, and a string avoids floating-point
  rounding. The client converts when it needs to calculate.
- **A repair document leaves out** the customer's phone (personal data the
  accounting program does not need), the mechanic, the bike's color, the quote
  and response timestamps, creation and update timestamps, and every foreign
  key (`bike_id`, `staff_member_id`, `service_id`). Accounting needs what was
  charged, to whom, and the state, not the internal wiring.
- **CORS** allows only `http://localhost:8000` and `https://arantxa1942.github.io`,
  and only for reading the public price list. Routes that need the token are not
  opened to any origin.