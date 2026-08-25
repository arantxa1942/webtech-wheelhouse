# Decisions — Wheelhouse
## Can more then one custumer bring their bike to be repaired? 

**Solution:** The owner said that in March two bikes were confused because they were similar and were repaired at similar times, so it is possible.

**Assumption:** the shop can have several bikes from different
customers in the workshop at the same time, each going through its own
repair independently.

**What would change if the answer is the other way:** if the shop could
only take in one bike at a time, `repairs` would not need a `status` that
tracks parallel repairs — the whole system could rely on there being at
most one bike "in the shop" at any moment, and the confusion described in
March could never happen in the first place. Since we know from the
description that it *does* happen, our model keeps `bike_id` and
`mechanic_id` as independent foreign keys on `repairs`, allowing many
repairs to exist and progress at the same time.

## What happends if the customer never responds to the quote? 

**Solution:** The owner describes two outcomes when a repair needs apprroval

What happends if the promised date passes and the repair is not finished 

**Solution:** the owner says " I want to see that on the screen before the customer calls me and tells me" wich shows they want to know about late repairs. But the descrioption never says what the shop is supposed to do about it.

**Assumption:** The system only surfaces overdue repairs on a screen for the owner to see. No automatic action is taken and the promised date is not changed on it´s own. 

**What would change if the answer is the other way:** if the shop wants the
system to notify the customer automatically, or to require the owner to set
a new promised date once one is missed, `repairs` would need extra columns
(e.g. `original_promised_date`, `notified_at`), and the lifecycle would need
a way to track that a repair's date was renegotiated instead of just being
late.

## What happens when the mechanic takes a picture of the bike?

The owner says "we take photos when the bike arrives so that nobody argues
later about who made the scratch." This makes it clear photos are taken at
intake, but it does not say what happens afterward, whether a photo is
just stored as proof and never looked at again unless there is a dispute,
or whether it becomes part of what a mechanic or customer normally sees
when checking on a repair.

**Assumption:** photos are stored and linked to the repair, but they
are only shown if someone explicitly opens the repair's details. They are
not shown openly

**What would change if the answer is the other way:** if photos are meant
to be checked regularly (for example, a mechanic confirming there is no new
damage before starting work), the wireframes would need a dedicated step or
screen for reviewing photos as part of the repair workflow, not just an
optional detail buried in the repair's page.
