# webtech-wheelhouse

## Wheelhouse

It's a small bicycle repair shop. It has a functional system for providing
good service when repairing a bike.

### Who uses it:

- **Customer:** they bring their bike in for repair, they get a price
  before any work begins, they are asked for approval of the price, and
  they have their repair history kept private.
- **Counter staff:** they record customers and bikes at arrival, they check
  for updates, and they hand the bike back when it is ready.
- **Mechanics:** they repair the bikes, keeping a record of what was done,
  and make sure to take a picture of the bike at intake to avoid any
  confusion.
- **The owner:** makes sure everything is working accordingly.

  ## Documents:
  - [`docs/user-stories.md`](docs/user-stories.md)
  - [`docs/domain-model.md`](docs/domain-model.md)
  - [`docs/decisions.md`](docs/decisions.md)
  - [`docs/wireframes.md`](docs/wireframes.md)
  
## Prerequisites
Ruby 3.4.9 (see .ruby-version)
Rails 8.1.3
Node 22.x and Yarn (see .node-version)
PostgreSQL, running locally, with a role that can create databases  
## Setup

Run these commands in order from the project root:

bash
bundle install
yarn install
bin/rails db:create
bin/rails db:prepare
## Running the app
bash
bin/dev

This starts the Rails server and the Sass watcher together (see Procfile.dev). Open the app at http://localhost:3000.