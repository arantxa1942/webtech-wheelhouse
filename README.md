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
- PostgreSQL running locally, with a role that has the same name as your operating system user and can create databases. If you do not have one: `sudo -u postgres createuser -s "$USER"`

## Setup

Run these commands from the project root:

```bash
bundle install
yarn install
bin/rails db:prepare
bin/rails db:seed
```

`db:seed` can be run again at any time. It rebuilds the same data.

## Running the app

```bash
bin/dev
```

This starts the Rails server and the Sass watcher together. Open
[http://localhost:3000/services](http://localhost:3000/services) to see the
price list, which is the only page that does not need an account. Every
other page asks you to sign in at
[http://localhost:3000/session/new](http://localhost:3000/session/new).

## Database

The schema is created by migrations in `db/migrate/`.

```bash
bin/rails db:migrate:status
```

The workshop seed data is in `db/seeds.rb`.

```bash
bin/rails db:seed
```

## Accounts

The seed creates these accounts. **They exist only in development** and must
never be used anywhere else.

| Email | Password | Role | Staff member |
|---|---|---|---|
| owner@wheelhouse.test | Owner-Rueda-2026 | owner | Ignacio Vargas |
| maria@wheelhouse.test | Maria-Cadena-2026 | mechanic | María González |
| diego@wheelhouse.test | Diego-Pedal-2026 | mechanic | Diego Rojas |
| camila@wheelhouse.test | Camila-Freno-2026 | mechanic | Camila Soto |
| valentina@wheelhouse.test | Vale-Mostrador-2026 | counter | Valentina Pérez |
| visitor@wheelhouse.test | Visitor-Manubrio-2026 | counter (default) | none |

Anyone can also create an account at
[http://localhost:3000/registration/new](http://localhost:3000/registration/new).
A new account always gets the default role, `counter`.

## Emails in development

The application never sends real email. Every email it sends in development
(the welcome email and the password reset email) is saved and shown at
[http://localhost:3000/letter_opener](http://localhost:3000/letter_opener).
Keep the server running and open that page.

To try the forgotten password flow: click "Forgot your password?" on the
sign-in page, enter one of the emails above, open the message at
`/letter_opener`, follow the link, choose a new password and sign in. The
link stops working after 15 minutes and after the password changes.

The look of each email, without sending anything, is at
[http://localhost:3000/rails/mailers](http://localhost:3000/rails/mailers).
