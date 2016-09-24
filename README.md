## Payment Service
This API has been implemented to allow several operations to be performed through the Coolpay API (http://docs.coolpayapi.apiary.io/#reference/0/authentication/login?console=1)

The payment service has been built with Rails 5 and tested with Rspec 3.5.3

To download the necessary gems, run:
```
bundle install
````

To start the application, just run the following command:
```
rails s
```

To run the tests, run the following command:
```
rspec
```

Below are listed the requests that can be sent to the payment api, with related responses:

# Login

- request

```
POST http://localhost:3000/login

```

- response

```
{
    "token": "bd5883de-34a8-40d2-b594-15170cecd9d1"
}
```

# Create a recipient

- request (a bearer token has to be provided)

```
POST http://localhost:3000/recipients

{"recipient": {"name": "cosimo"}}

```

- response

```
{
    "recipient": {
        "name": "cosimo",
        "id": "5f0adfbe-14f3-4426-b152-49fcd7209f0b"
    }
}
```

# Send payment to a recipient

- request (a bearer token has to be provided)

```
POST http://localhost:3000/payments

{
  "payment": {
  	"amount": "10.50",
    	"currency": "GBP",
    	"recipient_id": "5f0adfbe-14f3-4426-b152-49fcd7209f0b"
    }
}

```

- response

```
{
    "payment": {
        "status": "processing",
        "recipient_id": "5f0adfbe-14f3-4426-b152-49fcd7209f0b",
        "id": "1ca0d0ec-d800-406a-a1ac-d31ff8ebddd0",
        "currency": "GBP",
        "amount": "10.50"
    }
}
```

# Get info for a specific payment

- request (a bearer token has to be provided)

```
GET http://localhost:3000/payments/1ca0d0ec-d800-406a-a1ac-d31ff8ebddd0

```

- response

```
{
    "payment": {
        "status": "paid",
        "recipient_id": "5f0adfbe-14f3-4426-b152-49fcd7209f0b",
        "id": "1ca0d0ec-d800-406a-a1ac-d31ff8ebddd0",
        "currency": "GBP",
        "amount": "10.50"
    }
}
```

# Postman

The following Postman collection can be imported into Postman for ready to use requests:

```
{"id":"1e336323-6923-98ca-d04b-bae5b78c69ed","name":"Coolpay API","timestamp":1474672391535,"requests":[{"collectionId":"1e336323-6923-98ca-d04b-bae5b78c69ed","id":"2d6143fa-16a3-058e-8dc3-00a8a08d1342","name":"Make payment","description":"","url":"http://localhost:3000/payments","method":"POST","headers":"Content-Type: application/json\nAuthorization: Bearer 0addb9f5-a368-4bf1-9785-865dc7360455\n","data":"{\"payment\": {\n  \"amount\": \"10.50\",\n  \"currency\": \"GBP\",\n  \"recipient_id\": \"3d489042-fb2b-4efc-8906-280c82efbae3\"\n}\n}","dataMode":"raw","timestamp":0,"version":2,"time":1474675103570},{"collectionId":"1e336323-6923-98ca-d04b-bae5b78c69ed","id":"48f8e4a5-eff7-d7a3-6832-b4fbdac464db","name":"Create recipient","description":"","url":"http://localhost:3000/recipients","method":"POST","headers":"Content-Type: application/json\nAuthorization: Bearer 0addb9f5-a368-4bf1-9785-865dc7360455\n","data":"{\"recipient\": {\"name\": \"cosimo\"}}","dataMode":"raw","timestamp":0,"version":2,"time":1474676211218},{"collectionId":"1e336323-6923-98ca-d04b-bae5b78c69ed","id":"6cb78b93-5175-0d0f-d8fa-4d227bc9a720","name":"Get token","description":"","url":"http://localhost:3000/login","method":"POST","headers":"Content-Type: application/json\n","data":"{\"username\": \"cosimo\", \"apikey\": \"20F03CC806A81392\"}","dataMode":"raw","timestamp":0,"responses":[],"version":2},{"collectionId":"1e336323-6923-98ca-d04b-bae5b78c69ed","id":"fdcda050-c881-6d40-104a-f9032543bc18","name":"Get payment","description":"","url":"http://localhost:3000/payments/1ca0d0ec-d800-406a-a1ac-d31ff8ebddd0","method":"GET","headers":"Content-Type: application/json\nAuthorization: Bearer bd5883de-34a8-40d2-b594-15170cecd9d1\n","data":"{\n  \"payment\": {\n\t\"amount\": \"10.50\",\n  \t\"currency\": \"GBP\",\n  \t\"recipient_id\": \"5f0adfbe-14f3-4426-b152-49fcd7209f0b\"\n  }\n}","dataMode":"raw","timestamp":0,"version":2,"time":1474675978517}]}
```
