# OmniAuth MercadoLibre

This is OmniAuth strategy for authenticating to MercadoLibre. To
use it, you'll need to sign up for an OAuth2 Application ID and Secret
on the [MercadoLibre Applications Page](http://applications.mercadolivre.com.br).

## Installing

Add to your `Gemfile`:

```ruby
gem 'omniauth-mercadolibre'
```

Then `bundle install`.

## Usage

`OmniAuth::Strategies::MercadoLibre` is simply a Rack middleware. Read the OmniAuth docs for detailed instructions: https://github.com/intridea/omniauth.

Here's a quick example, adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :mercadolibre, ENV['MERCADOLIBRE_APP_ID'], ENV['MERCADOLIBRE_APP_SECRET']
end
```
## Auth Hash

Here's an example *Auth Hash* available in `request.env['omniauth.auth']`:

```json
{
  "provider": "mercadolibre",
  "uid": "12345678",
  "info": {
    "username": "gullitmiranda",
    "email": "gullitmiranda@requestdev.com.br",
    "first_name": "Gullit",
    "last_name": "Miranda",
    "url": "http://perfil.mercadolivre.com.br/gullitmiranda",
    "name": "Gullit Miranda"
  },
  "credentials": {
    "token": "APP_USR-7835951963654614-012316-4d69c027164dadd1b5829d62cfc733cf__D_J__-12345678",
    "refresh_token": "TG-52e17bf8e4b0295cf4be2f44",
    "expires_at": 1390530648,
    "expires": true
  },
  "extra": {
    "access_token": {
      "token_type": "bearer",
      "scope": "offline_access read write",
      "access_token": "APP_USR-7835951963654614-012316-4d69c027164dadd1b5829d62cfc733cf__D_J__-12345678",
      "refresh_token": "TG-52e17bf8e4b0295cf4be2f44",
      "expires_at": 1390530648
    },
    "raw_info": {
      "id": 12345678,
      "nickname": "gullitmiranda",
      "registration_date": "2006-06-28T11:32:00.000-04:00",
      "first_name": "Gullit",
      "last_name": "Miranda",
      "country_id": "BR",
      "email": "gullitmiranda@requestdev.com.br",
      "identification": {
        "number": "12345678901"
      },
      "address": {
        "state": "BR-SP",
        "city": "São Paulo",
        "address": "Rua onde judas perdeu as botas",
        "zip_code": "12345678"
      },
      "phone": {
        "area_code": "12",
        "number": "12345678",
        "verified": false
      },
      "alternative_phone": {
        "area_code": "12",
        "number": "12345678"
      },
      "user_type": "normal",
      "tags": [
        "normal"
      ],
      "points": -1,
      "site_id": "MLB",
      "permalink": "http://perfil.mercadolivre.com.br/gullitmiranda",
      "shipping_modes": [
        "custom",
        "not_specified"
      ],
      "seller_experience": "NEWBIE",
      "seller_reputation": {
        "transactions": {
          "period": "historic",
          "total": 0,
          "completed": 0,
          "canceled": 0,
          "ratings": {
            "positive": 0,
            "negative": 0,
            "neutral": 0
          }
        }
      },
      "buyer_reputation": {
        "canceled_transactions": 0,
        "transactions": {
          "period": "historic",
          "total": 2,
          "completed": 0,
          "canceled": {
            "total": 2,
            "paid": 0
          },
          "unrated": {
            "total": 0,
            "paid": 0
          },
          "not_yet_rated": {
            "total": 0,
            "paid": 0,
            "units": 0
          }
        }
      },
      "status": {
        "site_status": "active",
        "list": {
          "allow": false,
          "codes": [
            "identification_pending",
            "identification_empty_or_invalid_doc_type"
          ],
          "immediate_payment": {
            "required": false
          }
        },
        "buy": {
          "allow": true,
          "immediate_payment": {
            "required": false
          }
        },
        "sell": {
          "allow": true,
          "immediate_payment": {
            "required": false
          }
        },
        "billing": {
          "allow": false,
          "codes": [
            "identification_pending",
            "identification_empty_or_invalid_doc_type"
          ]
        },
        "mercadopago_tc_accepted": true,
        "mercadopago_account_type": "personal",
        "mercadoenvios": "not_accepted",
        "immediate_payment": false,
        "confirmed_email": true
      },
      "credit": {
        "consumed": 0,
        "credit_level_id": "MLB5"
      }
    }
  }
}
```


## License

Copyright (c) 2014 Gullit Miranda.

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
