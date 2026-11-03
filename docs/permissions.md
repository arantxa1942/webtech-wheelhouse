# Permissions

Enforced by the Pundit policies in `app/policies/`.
A refused request answers 403. A visitor with no session is sent to sign in.

## Services
| Action | Owner | Counter | Mechanic |
|---|---|---|---|
| index, show | Yes (also public) | Yes (also public) | Yes (also public) |
| new, create | Yes | No | No |
| edit, update | Yes | No | No |
| destroy | Yes | No | No |

## Staff
| Action | Owner | Counter | Mechanic |
|---|---|---|---|
| index, show | Yes | Yes | Yes |
| new, create | Yes | No | No |
| edit, update | Yes | No | No |
| destroy | Yes | No | No |

## Customers
| Action | Owner | Counter | Mechanic |
|---|---|---|---|
| index, show | Yes | Yes | No |
| new, create | Yes | Yes | No |
| edit, update | Yes | Yes | No |
| destroy | Yes | No | No |

## Bikes
(same table as Customers)

## Repairs
| Action | Owner | Counter | Mechanic |
|---|---|---|---|
| index, show | Every repair | Every repair | Only repairs assigned to their staff member (none if the account has no staff member) |
| new, create | Yes | Yes | No |
| edit, update | Every repair | Every repair not handed back (`returned`) | Own repairs not handed back |
| destroy | Yes | No | No |
| destroy intake photo | Yes | Only if not handed back | No |

### Fields each role writes (repair form)
| Role | Fields |
|---|---|
| Owner, Counter | bike, mechanic, state, received/quoted/returned dates, promised day, customer response and date, diagnosis, intake photos, service lines and prices |
| Mechanic | state, diagnosis, intake photos |

The account that took the repair in is read from the session; it is never a field.