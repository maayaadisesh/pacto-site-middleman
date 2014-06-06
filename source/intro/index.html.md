---
title: Intro
layout: page
---

# What is Pacto?

Pacto is a testing and validation framework for RESTful services. Pacto uses service contracts to help arbitrate between service consumers and producers, so we imagine Pacto as a judge setting contract disputes:

![Pacto](/images/judge2.png 'Pacto: the judge')

# Important Concepts
Pacto builds on top of WebMock and Faraday and so it has many familiar HTTP concepts, but it is not a generic HTTP testing framework. It is a framework for testing RESTful services, and so it brings adds a few higher-level concepts on top regular HTTP testing.

## Services

A generic HTTP testing library deals with requests and URLs, but it does not always have a higher-level concept of a "service". This concept is very important to Pacto: it needs to know if similar requests are for the same service or different ones, so it can apply the right validation rules and track usage for reports.

### REST

Pacto is not currently designed to deal with any type of service, or even any type of HTTP service. It is currently only designed for [RESTful services](http://www.infoq.com/articles/rest-introduction) which use JSON. This is our focus because the trend over the last few years has been moving away from SOAP/XML APIs and towards REST/JSON.

We usually talk about services in terms of service consumers and service producers.

### Consumers

A service consumer is the client that uses a service. In the case of RESTful services, they do this by sending HTTP requests. Service consumers often need to test their system in isolation from the services they consume, so they can test faster, offline, or without incurring costs that would be required if they used real services. A common challenge for consumers is to be able to do this isolated testing and remain confident they will be able to integrate with the real provider. They will also want to know if a problem during integration testing is because of a bug in the consumer code, or because the provider's service did not match their assumptions.

### Providers

A service producer is the one who provides the service being called. This means they are in control of the structure and behavior of the service, but that they might need to keep promises to many different consumers. Traditionally this makes the service very rigid and difficult to change once it has a few consumers. Contract-based testing approaches try to make it possible for providers to keep track of their commitments to each client so they can remain agile.

## Contracts

Pacto enables both Contract and Collaboration Testing. Chris Bartling gives a good summary:

<blockquote>
  <p><strong>Collaboration tests</strong> prove that the client interacts with its collaborators correctly; the client sends the correct messages and message arguments to the collaborator and appropriately handles all outputs from the collaborator. This is traditionally what I have used mock objects for and that seems to be what J.B. is arguing one should do for collaboration testing.</p>
  <p><strong>Contract testing</strong>, on the other hand, deals with testing that an interface implementation accurately respects the interface it is implementing. Does the implementor support the contract it declares to support?</p>
  <cite>Chris Bartlin - <a href="http://bartling.blogspot.com/2012/01/understanding-power-of-isolated-object.html">Understanding the power of isolated object testing</a></cite>
</blockquote>

Collaboration testing is a familiar form of integration testing, but Contract testing requires us to introduce a new concept: the service contract

![Contract](images/contract_stack.png)

In order to define the interface a service supports, Pacto needs to describe the:
- Location of the service
- Expectations about service metadata (HTTP headers)
- Expectations about service content (HTTP message bodies)

We have used some existing standards to help us describe each of these parts.

### URI Templates

We use URI Templates (as defined by the [RFC 6570](http://tools.ietf.org/html/rfc6570) in order to describe the location of services. This is a very important characteristic because Pacto uses the URI Template like a primary key. Pacto decides which service a request belongs to by matching it against the URI Template.

### JSON Schema

JSON-Schema is used to validate the structure and format of JSON data. Pacto uses JSON schema to describe the rules for data interchanged by a service: both the message body sent by a service consumer as part of a request (when applicable) and the data returned in the message by by the service provider's response.

Here's an example JSON-Schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "required": [
    "ping"
  ],
  "properties": {
    "ping": {
      "type": "string",
      "pattern": "^pong$"
    }
  }
}
```

This short example validates:
- The overall JSON is an object
- The object contains a property named ping
- The value of "ping" matches a regular expression (forcing it to be exactly "pong")

So this JSON (and in this case, only this JSON) would be valid:

```json
{
  "ping": "pong"
}
```

See [Wikipedia](http://en.wikipedia.org/wiki/JSON#Schema_and_Metadata) and [json-schema.org](http://json-schema.org/) for more examples.

# What's next?

- Dive into the [Contract Format](/intro/contracts/)
- Or how to [test consumers](/intro/consumers/) or [test providers](/intro/providers/)

# Further reading

- Martin Fowler's description of [Integration Contract Testing](http://martinfowler.com/bliki/IntegrationContractTest.html) and [Consumer-Driven Contracts](http://www.martinfowler.com/articles/consumerDrivenContracts.html)
- [REST in Practice](http://restinpractice.com/book/book.html) by Dr. Jim Webber, Savas Parastatidis, and Ian S Robinson.
- The [json-schema](http://json-schema.org/) draft.
- [URI templates](http://tools.ietf.org/html/rfc6570) and how they're used by [WebMock](https://github.com/bblimke/webmock)