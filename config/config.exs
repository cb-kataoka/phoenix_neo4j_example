# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :phoenix_neo4j_example, PhoenixNeo4jExampleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1Sd1a+u2TEryFW4dTtq0KHxsrSr53LHdPtcrSkBjvZ94gxB/MZObXTNfoyu/lYNl",
  render_errors: [view: PhoenixNeo4jExampleWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhoenixNeo4jExample.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :cors_plug,
  origin: ~r/https?.*localhost:\d+$/

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
