## Payment Service
This API has been implemented to allow several operations to be performed through the Coolpay API (http://docs.coolpayapi.apiary.io/#reference/0/authentication/login?console=1)

The payment service has been built with Rails 5 and tested with Rspec 3.5.3

Below are listed the requests that can be sent to the payment api, with related response:

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
