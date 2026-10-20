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

`GET /api/v1/repairs?state=<state>` filters by state: `received`, `quoted`,
`approved`, `declined`, `in_progress`, `ready_for_pickup`, `returned`. A value
that is not a state answers 400 with the list of valid states.

Any other path under `/api` answers 404 in JSON.

## Documents

### Service

The same shape in `index`, `show` and `create`. `repairs_count` is how many
repairs the service has been charged on.

```json
{
  "id": 77,
  "name": "Bearing adjustment",
  "price": "9000.00",
  "repairs_count": 1
}
```

`POST /api/v1/services` takes a JSON body such as
`{ "service": { "name": "Tune-up", "price": "12000" } }`.
It answers `201 Created`, with this document as the body and the service's URL
in the `Location` header. Attributes outside `name` and `price` are dropped.

### Repair

```json
{
  "id": 56,
  "state": "received",
  "received_on": "2026-09-21",
  "promised_on": null,
  "returned_on": null,
  "bike": {
    "brand": "Orbea",
    "model": "Vector 20",
    "serial_number": "ORB-V20-2021-035"
  },
  "customer": {
    "name": "Carlos Fuentes"
  },
  "lines": [
    {
      "service": "Full safety inspection",
      "price_charged": "12000.00"
    }
  ],
  "total": "12000.00",
  "overdue": false,
  "customer_answer": null
}
```

`total`, `overdue` and `customer_answer` are not columns: the total is the sum
of the lines, `overdue` comes from the lifecycle, and `customer_answer` is the
customer's response (`null` until they answer).

### Collection of repairs

A JSON array, newest first, with no pages. Each element has the shape of a
single repair.

```json
[
  {
    "id": 56,
    "state": "received",
    "received_on": "2026-09-21",
    "promised_on": null,
    "returned_on": null,
    "bike": { "brand": "Orbea", "model": "Vector 20", "serial_number": "ORB-V20-2021-035" },
    "customer": { "name": "Carlos Fuentes" },
    "lines": [ { "service": "Full safety inspection", "price_charged": "12000.00" } ],
    "total": "12000.00",
    "overdue": false,