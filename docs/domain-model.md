```
Table customers {
  id integer [pk]
  name varchar
  phone varchar
  update_at
}

Table bikes {
  id integer[pk]
  customer_id integer [ref: > customers.id]
  make varchar
  model varchar
  serial_number varchar [unique]
  update_at
}

Table mechanics {
  id integre [pk]
  name varchar
  update_at
}

Table job_types {
  id integre [pk]
  name varchar
  current_price decimal
  update_at
}

Table repairs{
  id integer [pk]
  bike_id integre [ref: >bikes.id]
  mechanic_id integer [ref: >mechanics.id]
  status varchar
  promised_on date
  approved_at datetime
  completed_at datetime
  created_at datetime
  update_at
}

Table repair_jobs{
  id integer [pk]
  repair_id integer [ref: >repairs.id]
  job_type_id integer [ref: >job_types.id]
  price decimal
  update_at
}
```
![Modelo de Dominio](../photo/photo.png)

| Entity | Story |
|---|---|
| customer | counter staff: record a customer's name and phones number when a bike arrives  |
| bikes | mechanic: record a bike's brand, model snd serial number at intake, so that two bikes are never to be confused  |
| mechanic | mechanic: write diagnosis and notes on a bike into the system, so that any mechanic or counter staff can answer a customer's call without walking to the back to find out |
| job_types |  Customer: see the shop's price list for common jobs on the website       |
| repairs    |Customer: be told the price of the repair and asked to approve it before any work begins |
| repair Job |Mechanic: select one or more jobs from the price list for a repair, so that the total cost is calculated consistently|
| photo       | Mechanic: take a picture of the bike at arrival, so that later nobody gets confused about who made a scratch |

## The thing and the copy of the thing
Every customer has their own bike, but the problem is that a bike is not
unique among everything else on the market. The mix-up in March was proof of
this, because those two bikes shared the same make and model, causing
confusion. Our system prevents this by giving each bike a serial number that
is unique across the whole shop, not just per customer. Even if two bikes
share almost every other characteristic, this specific detail cannot be
missed.

## Derived, or stored?
Our schema does not have a column for whether a repair is overdue. This value
can be calculated from data we already have: the promised date and the
current status. If the promised date already passed and the bike was not
picked up, the repair is overdue. We do not need to store this, because it
would go out of date the moment the day changes.

The price charged for a job looks like it could be derived too, but we stored
it anyway. The price list changes every January, and sometimes a mechanic
charges less than the list price for a regular customer. If we did not store
the price charged and used the current list price instead, old invoices would
change every time the list changes. That is exactly what the owner said
should not happen.
