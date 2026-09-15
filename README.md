# webtech-wheelhouse

## Wheelhouse

It's a small bicycle repair shop. It has a functional system for providing
good service when repairing a bike.

### Who uses it

- **Customer:** They bring their bike in for repair, get a price before work
  begins, approve or decline the price, and have a private repair history.
- **Counter staff:** They record customers and bikes at arrival, check for
  updates, and hand the bike back when it is ready.
- **Mechanics:** They repair bikes and keep a record of the services performed.
- **The owner:** Makes sure everything is working accordingly.

## Documents

- [User stories](docs/user-stories.md)
- [Domain model](docs/domain-model.md)
- [Decisions](docs/decisions.md)
- [Wireframes](docs/wireframes.md)

## Prerequisites

- Ruby 3.4.9 (see `.ruby-version`)
- Rails 8.1.3
- Node.js 22.x and Yarn (see `.node-version`)
- PostgreSQL running locally, with a role named `arant` that can create databases

## Setup

Run these commands from the project root:

```bash
bundle install
yarn install
bin/rails db:prepare
```

## Running the app

```bash
bin/dev
```

This starts the Rails server and the Sass watcher together. Open
[http://localhost:3000/services](http://localhost:3000/services) to see the
seeded service price list.

## Database

The schema is created by migrations in `db/migrate/`.

```bash
bin/rails db:migrate:status
```

The workshop seed data is in `db/seeds.rb`.

```bash
bin/rails db:seed
```
