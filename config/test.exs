use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :fleet, Fleet.Repo,
  username: "fleetdb",
  password: "fleetdb",
  database: "fleet_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "db",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :fleet, FleetWeb.Endpoint,
  http: [port: 4002],
  server: false

 config :fleet, Fleet.Accounts.Guardian,
  issuer: "fleet",
  secret_key: "keepitlikeasecret"

# Print only warnings and errors during test
config :logger, level: :warn
