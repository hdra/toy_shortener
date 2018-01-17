# ToyShortener

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Build a small link shortener service with an API as well as a small web front-end.

The link shortener should be able to receive a URL and give back a shortened URL.

When a user accesses the shortened URL he should be redirected to the full URL.

It should have an API endpoint where you can query stats around a particular shortened URL giving you details about the users that have visited the URL with as much information as you can get on that person.

The code must end up in a public GitHub or Bitbucket repository.

The server must run with a single start-server command on a Linux, Windows or macOS machine and then be accessible through "localhost:4555".

Commit often and make your commit messages descriptive so we can see your process.

Documentation, user authentication and tests are optional but welcome.

You do not need to use a full database, if you use one you must host it somewhere yourself on AWS, Azure, ... they have free tiers that will be more than enough for this exercise. For PostgresSQL https://www.elephantsql.com/plans.html is a great free option.
