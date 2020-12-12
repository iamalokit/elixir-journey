# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :live_chat,
  ecto_repos: [LiveChat.Repo]

# Configures the endpoint
config :live_chat, LiveChatWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "07aW/kZSdYq6XOWA2QEIb82J8xItnCgLORGDZOA1YWpyRTGBrbLXErM0CVdCYNki",
  render_errors: [view: LiveChatWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: LiveChat.PubSub,
  live_view: [signing_salt: "kItC0Oet"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
