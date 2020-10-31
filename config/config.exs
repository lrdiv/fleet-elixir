# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :fleet,
  ecto_repos: [Fleet.Repo]

config :fleet, Fleet.Repo,
  types: Fleet.PostgresTypes

# Configures the endpoint
config :fleet, FleetWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QTtL3RtZ5M+ls3RB6Gi4GLTNRffzhRxBT/+5/Xi1/TDSV2/paAfyYVJcJo8u8Uhg",
  render_errors: [view: FleetWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Fleet.PubSub,
  live_view: [signing_salt: "uxGzQ625"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :jsonapi,
  namespace: "/api",
  json_library: Poison

config :mime, :types, %{
  "application/vnd.api+json" => ["json-api"]
}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
