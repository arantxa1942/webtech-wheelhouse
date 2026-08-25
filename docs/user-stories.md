# User Stories- Wheelhouse 
## Roles: 
- Customer
- Mechanic
- counter staff
- owener

## Counter Staff

1. As a counter staff member, i want to record a customer's name and phone number when a nike arrives, so that we know who to contact about the bike
2. As a counter staff, i want to tag a bike and tie it to the handdlebar, then put the bike on a rack, so the mechanic knows wich bike belongs to whom
3. As a counter staff member, i want to look to look the bike properly so i can call the person and let them know the cost of the repair and wait for their response

## Mechanic: 
1. As a mechanic, i want to record a bike's make, model and serial number at intake, so that two similar bikes are never to be confused

### Acceptance criteria: 
- A bike cannot be saved without a make, a model and a serial number.
- If a serial number already exists in the system, the mechanic is warned
  before saving a second bike with the same number.
- The recorded make, model and serial number are visible on the bike's page
  immediately after intake, without needing to reload or search separately.

3. As a Mechanic, i want to take a picture of the bike at arrival, so that later nobody gets confused on who made a scratch
4. As a mechanic, i want to write my notes on my own notebook, so that when a customer call to check on their bike i can tell them.

## Customer: 
1. As a customer, i want to be told the price of the repair and ask to approve it before any work begins, so that i am not charged for something i didn't agree to

### Acceptance criteria:
- The quoted price shown to the customer equals the sum of the selected jobs'
  current prices.
- Work cannot be marked as started on a repair that has not been approved.
- If the customer declines, the bike's status changes to ready for pickup
  with no charge, instead of remaining in an ambiguous state.
3. As a customer, i want my repair history to stay private from other customers, so that nobody else can read what was done to my bike
4. As a customer, i want to see the shop's price list for common jobs on the website, so that i don't have to call the shop to ask about prices

### Acceptance criteria: 
- Every job on the wall list appears on the piblic page with it's current price
- the price shown matches the proce currently in efect, not a proce from a previous year
- the page is visible without logging in or being a registered customer 

## Owner: 
1. As an owner, i want to update the price list every january without changing th proces on pas invoices, so that last year's invoices stay accurate
2. As an owner, I want to see which repairs are past their promised delivery date across all mechanics, so that I can call the customer myself before they call me.

### Acceptance Criteria: 
- A repair appreirs on the list when it's promised date is before today and the bike has no left the workshop yet
- the list is sorted with the most overdue repair first
- Each row shows the customer's name, the bike, and how many days past the promised date
- if no repair is currently overdue, the screen says so explicity inted of showing and empy table


4. As an owner, I want to apply a discount to a job's list price for a specific repair, so that I can charge less for a regular customer or an easier-than-expected job without changing the price list itself.


