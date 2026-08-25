```
Table customers {
  id integer [pk]
  name varchar
  phone varchar
}

Table bikes {
  id integer[pk]
  customer_id integer [ref: > customer.id]
  make varchar
  model varchar
  S_number varchar [unique]
}

Table mechanic {
  id integre [pk]
  name varchar
}

Table job_type {
  id integre [pk]
  name varchar
  current_price decimal
}

Table repairs{
  id integer [pk]
  bike_id integre [ref: >bikes.id]
  mechanic_id integer [ref: >mechanic.id]
  status varchar
  diagnosis text
  promised_date date
  approved datetime
  completed_at datetime
  created_at datetime
}

Table repair_job {
  id integer [pk]
  repair_id integer [ref: >repair.id]
  job_type_id integer [ref: >job_type.id]
  price decimal
}

Table photos {
  id integer [pk]
  repair_id [ref: >repairs.id]
  url varchar
  taken datetime
}

```
