# Nebulab - Rails Technical Test

Welcome to Nebulab's technical test for Ruby on Rails engineers!

The goal of this test is to evaluate your skills with full-stack Ruby on Rails development in a
real-world scenario. Read the setup instructions, assignment and evaluation criteria carefully, and
feel free to email your Hiring Manager if you have any questions.

Good luck!

## Time limit

It should take you approximately 4-8 hours to solve both assignments in this test. We want to be
respectful of your time, so make sure you're not investing more than 8 hours in the solution!

## System requirements

This application requires the following system dependencies:

- Ruby 3.0.3
- Node 16.3+ and Yarn
- PostgreSQL 14 (installed automatically)
- Redis 6 (installed automatically)
- libvips (installed automatically)

## Running the application

### Installing dependencies

If you're on macOS, you can set up system dependencies like PostgreSQL, Redis and libvips with one
command:

```console
$ brew bundle --no-lock
```

If you're on another platform, follow the specific instructions for your OS.

### Installing the app

You should be able to set up the application with one command:

```console
$ ./bin/setup
```

This will install all system- and application-level dependencies and set up your database.

### Running the app

Once the installation process has completed, you can run the app by running the following:

```console
$ ./bin/dev
```

This will spin up the app at http://localhost:3000.

### Test credentials

Use the following credit card credentials in the checkout flow:

- Name on card: any name
- Number: 4242 4242 4242 4242
- Expiration: any date in the future
- CVC: any three- or four-digit number

All other fields can be filled with whatever values you want.

## Your assignments

This is a lightweight eCommerce application built with Ruby on Rails, Turbo and TailwindCSS.

From the application's home page, you can already browse the product catalog, add products to your
cart and complete the checkout flow.

### Assignment 1: Delivery estimates

Currently, customers have no idea about the delivery times for the products they order. This leads
to a lot of work for the customer support department, who need to constantly answer the same
questions about delivery times. This is further complicated by the fact that delivery times vary
per country, as each country will use a different shipping method.

Your Product Manager has asked your team to implement support for dynamic shipping methods, based on
the customer's shipping country. Here are the requirements:

- Store operators must be able to configure shipping methods. Each shipping method will have a name,
  delivery time (in days) and a list of supported countries.
  - Each country can have, at most, one shipping method.
  - You don't need to implement a UI for managing shipping methods. For the time being, it's
    acceptable to manage them from the Rails console.
- Upon selecting a shipping country, customers should be able to see the shipping method and
  delivery time for their order on the checkout form, beneath the "Confirm order" button.
  - If no shipping method is available for their country, it means we don't deliver to the
    customer's country: in that case, customers should see an error message and shouldn't be able to
    complete the checkout flow.
- On the order summary page, the customer should see a recap of the shipping method and delivery
  time for their order.

### Assignment 2: ERP integration

An ERP (Enterprise Resource Planning) is a particular type of software that allows companies to
streamline all of their business operations and have a single source of truth for their business's
data. As an eCommerce brand scales, it is fairly common to stop managing orders in your eCommerce
platform and instead start using an ERP.

Your second assignment is to implement exactly this kind of ERP integration!

In order to accomplish this, you will have to integrate with the API of our ERP and save the
ID returned by the ERP system in the database. Here are the requirements:

- When an order is completed, make an API call to `POST /erp/orders` with the expected payload.
- The API endpoint will respond with an entity ID which must be associated with the order.

#### Expected payload

```
POST /erp/orders

{
   "order_id": 1,
   "shipping_address": {
      "full_name": "John Doe",
      "line1": "8400 NW 36th",
      "line2": null,
      "zip": "33166",
      "city": "Doral",
      "state": "FL",
      "country": "US"
   },
   "line_items": [{
      "product_description": "Earthen Bottle",
      "quantity": 2,
      "total": 15.0
   }],
   "total": 30.0
}
```

#### Response

```
201 Created

{
   "id": "or_6b578a840a2b46c2"
}
```

## Submitting your solution

Follow this workflow when working on a new feature:

1. Create a new branch for your feature.
    - Follow the `{username}/{feature}` naming convention for branches, e.g. `jdoe/multicurrency-support`.
2. Work on your feature in the branch.
    - Use [Standard](https://github.com/testdouble/standard) for maintaining a consistent coding style.
    - Write unit and integration tests with RSpec for all features.
3. Commit and rebase your branch often.
    - Squash, separate and reword commits [as needed](https://mislav.net/2014/02/hidden-documentation/)
      for clarity!
4. When the feature is ready, open a PR.
    - Make sure to write a thorough description for your PR: explain what you have changed and how,
      including the rationale behind any important architectural choices you have made.
5. Use the link provided in the test's email you received and paste the PR URLs in the notes.

Your Hiring Manager will review your PR once, and will most likely ask clarifying questions and
leave feedback on areas for potential improvement. You should make sure to address all of their
comments, but feel free to push back if you feel strongly about any decisions you have made: we
expect you to act and communicate just as you would in a real professional setting.

## Evaluation criteria

We will evaluate your submission against the following set of criteria:

1. Your solution solves the problem specification.
2. Your solution includes tests as appropriate.
3. Your code is well-factored and comprehensible.
4. Your code follows established project conventions.
5. Your commit history is well-structured and useful.
6. Your PR description is well-written and useful.
7. You respond well to feedback given by your Hiring Manager.
8. You can explain the rationale behind your design choices.

## Got questions?

If you have any questions or doubts, feel free to email your Hiring Manager at any time!
