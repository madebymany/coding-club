# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :codingclub,
  ecto_repos: [Codingclub.Repo]

# Configures the endpoint
config :codingclub, CodingclubWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "LpgcB53Squ5p9zdtGwQLuBw3sjnHjVPVe3bxeeVeRZOIIOT9wFKssC9FFwK9IV7n", # This is used in dev and test environments 
  render_errors: [view: CodingclubWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Codingclub.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :scrivener_html,
  routes_helper: CodingclubWeb.Router.Helpers,
  view_style: :bootstrap

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
