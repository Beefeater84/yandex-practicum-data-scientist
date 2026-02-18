# Data Description

The schema of the `afisha` database `data-analyst-afisha` contains five tables.

## Table: `purchases`

Contains information about ticket orders:

- `order_id` — order identifier;
- `user_id` — identifier of the user who placed the order;
- `created_dt_msk` — order creation date in Moscow time;
- `created_ts_msk` — order creation date and time in Moscow time;
- `event_id` — event identifier from the `events` table;
- `cinema_circuit` — cinema network where the event takes place. If the event is not held in a cinema, this field will contain "none";
- `age_limit` — age restriction for the event;
- `currency_code` — payment currency;
- `device_type_canonical` — type of device used to place the order (e.g., `mobile` for mobile devices, `desktop` for computers);
- `revenue` — revenue from the order;
- `service_name` — name of the ticket operator;
- `tickets_count` — number of tickets purchased;
- `total` — total order amount.

## Table: `events`

Contains data about events available on the platform:

- `event_id` — event identifier;
- `event_name_code` — encoded name of the event;
- `event_type_description` — description of the event;
- `event_type_main` — main type of the event (e.g., theatrical performance, concert, etc.);
- `organizers` — event organizers;
- `city_id` — city identifier from the `cities` table where the event is held;
- `venue_id` — venue identifier from the `venues` table where the event is held.

## Table: `venues`

Contains information about event venues:

- `venue_id` — venue identifier;
- `venue_name` — name of the venue;
- `address` — address of the venue.

## Table: `city`

Contains a list of cities related to regions:

- `city_id` — city identifier;
- `city_name` — name of the city;
- `region_id` — region identifier from the `regions` table where the city is located.

## Table: `regions`

Contains a list of regions where events are held:

- `region_id` — region identifier;
- `region_name` — name of the region.
