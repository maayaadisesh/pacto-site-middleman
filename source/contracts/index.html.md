---
title: Contracts
layout: page
---

# Comments

Pacto Contract definitions are written in JSON. Strict JSON does not allow comments, but Douglas Crockford, the creator of JSON, wrote:

> Suppose you are using JSON to keep configuration files, which you would like to annotate. Go ahead and insert all the comments you like. Then pipe it through JSMin before handing it to your JSON parser.﻿

So, Pacto should ignore comments and we've used them in the examples below. If you find a situation where Pacto isn't ignoring comments, please [create an issue](https://github.com/thoughtworks/pacto/issues?state=open).

# Structure

Suppose you are using JSON to keep configuration files, which you would like to annotate. Go ahead and insert all the comments you like. Then pipe it through JSMin before handing it to your JSON parser.﻿

The basic structure of a Pacto Contract is:

```js
{
  "name": "My Service"
  "request": {
    // Defines the expectations for the request
  },
  "response": {
    // Defines expectations for the response
  },
  "examples": {
    // Optional section with example requests and responses
  }
}
```

## Request

The request clause defines the expectations for the requests sent by consumers. The request clause is made up of the following parts:

| property | type                  | required? | description                               |
|----------|-----------------------|-----------|-------------------------------------------|
| method   | [HTTP Verb][verb]     | yes       | The HTTP method (e.g. GET or POST)        |
| path     | [URI Template][uri]   | yes       | The service location                      |
| headers  | [Headers][headers]    |           | HTTP headers expected in the request      |
| params   | hash                  |           | Expected request query parameters         |
| schema   | [json-schema][schema] |           | JSON-Schema for the request body          |

Here's an example for a GET request, which doesn't usually have a schema:

```js
{
  "request": {
    "method": "get",
    "path": "/api/list_mcguffins",
    "headers": {
      "Content-Language": "en"
    },
    "params": {
      "limit": 5
    }
  }
}
```

## Response

The response section defines the expectations for the response. Only a status is required, but
responses that return data should define as schema.

| property | type                  | required? | description                               |
|----------|-----------------------|-----------|-------------------------------------------|
| status   | [HTTP Status][status] | yes       | HTTP method (e.g. GET or POST)            |
| headers  | [Headers][headers]    |           | HTTP headers expected in the response     |
| schema   | [json-schema][schema] |           | JSON-Schema for the response body         |

```js
{
  "response": {
    "headers": {
      "Content-Type": "application/json"
    },
    "status": 200,
    "schema": {
      "$schema": "http://json-schema.org/draft-03/schema#",
      "type": "object",
      "required": true,
      "properties": {
        "mcguffins": {
          "type": "array",
          "required": true
        }
      }
    }
  }
}
```

## Examples

The optional examples section contains named request/response pairs. These examples can be used for simulating consumer requests or stub a provider response, so you can decouple your testing.

Here are a few examples for the McGuffin service above:

```js
{
  "examples": {
    "default": // This example uses the default request
    {
      "request": {},
      "response": {
        "body": {
          "mcguffins": [
            "goldeneye",
            "rabbit's foot",
            "antimatter",
            "tesseract",
            "dead man's chest"
          ]
        }
      }
    },
    "limited": // This example sets the limit param to get a smaller list
    {
      "request": {
        "params": {
          "limit": 3
        }
      },
      "response": {
        "body": {
          "mcguffins": [
            "goldeneye",
            "rabbit's foot",
            "antimatter"
          ]
        }
      }
    }
  }
}
```



[verb]: http://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Request_methods
[uri]: http://tools.ietf.org/html/rfc6570
[schema]: http://json-schema.org/
[status]: http://en.wikipedia.org/wiki/List_of_HTTP_status_codes
[headers]: http://en.wikipedia.org/wiki/List_of_HTTP_header_fields