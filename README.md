# Fleet

Configuration:
  * Create a `docker/pgdata` directory to store docker postgres data
  * Add Guardian config with secret key to `config/dev.secret.exs`

```elixir
config :fleet, Fleet.Accounts.Guardian,
       issuer: "fleet",
       secret_key: "Secret key. You can use `mix guardian.gen.secret` to get one"
```

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
