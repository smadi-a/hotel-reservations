# README

## Why and how
This simple Rails API app will accept payloads with multiple schemas in order to create hotel reservations.

When the app gets a request, it attempts to identify the schema of the incoming payload, by looking at the keys and comparing them to predefined schemas.

If the schema is identified, the data can then be successfully parsed and a reservation created or updated.

## Setup and use
Define any new schemas in `config/defined_schemas.yml` (see below for example)

To start the application on port 3000: (note that defined schemas will load when the application starts)
```
bundle
rails s
```

The reservations endpoint can be accessed using `POST http://localhost:3000/api/reservations`.
An API token is required, can be defined in the request header as `x-api-key`.
The payload should be a JSON object, matching one of the defined schemas.

## Creating an API key
From Rails console:
```
APIKey.create(key: SecureRandom.base36, partner_name: 'AAA') # partner_name is optional
```

## Defining schemas
Copy one of the schemas defined in `config/defined_schemas.yml` and make the needed adjustments.

A schema definition works as follows:
  + Every schema must have the following fields defined [identifier, partner, code, start_date, end_date, adults, children, infants, status, host_currency, payout_price, security_price, guest_email, guest_first_name, guest_last_name, guest_phone_numbers]
  + identifier should have an MD5 hash of the schema, which can be generated using a rake tast (see below)
  + partner should have the name of the partner to identify this specific schema
  + Values for the fields like code, start_date, end_date, etc, should denote the location of this information in the desired payload
  + When the location of a specific field is within nested elements, you can use # to denote nesting (e.g: "guest#contact_info#email_address")
  + Any additional keys in the desired payload must be defined in the schema as undefined_1, undefined_2, etc

## Generating an MD5 hash for a payload's schema
Call the generator rake task
```
bundle exec rake json:generate_hash
```

The task will ask you to enter the JSON object, as a single line.
Once entered, the task will respond with the MD5 hash key.
This hash is used by the application for faster, more efficient schema identification.

## Running the test suite
```
bundle exec rspec
```

## Assumptions i've made
 + Based on my understanding of the requirements, i have created a single endpoint to handle creations and updates to reservations for this project, however i would normally implement separate ednpoints, as it aligns more with REST and HTTP semantics

## Limitations
 + Modifying defined schemas will require restarting the application server, however i'm okay with that as it's not expected to happen too frequently
 + Defining a new schema may appear a bit cumbersome, but again i wouldn't imagine it will be needed too often

## Notes
 + If i had more time i would have implemented rate limiting
 + If i was deploying this project in production, i would implement partner IP whitelisting as an additional security measure
 + I would have rather implemented logging for the API using Grape logging, but didn't have time to set that up
 + As an improvement i would add logic to state the date formatting for each schema to use when parsing dates
