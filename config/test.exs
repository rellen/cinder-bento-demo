import Config

config :ash,
  policies: [show_policy_breakdowns?: true],
  keyset_signing_secret: "8Ki5nORcI1McolzgB5veC0t7sjvQNf5ygoMOdcOw7ww"

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :cinder_bento, CinderBentoWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "d7MOS/h+Xscz6A7yHCL4tAuprFrH5NvqRTjQ+ywHpQ470LXiS6lTgRWHk4a3RjRU",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true

# Sort query params output of verified routes for robust url comparisons
config :phoenix,
  sort_verified_routes_query_params: true
