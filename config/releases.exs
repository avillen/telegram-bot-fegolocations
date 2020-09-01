import Config

config :fego, :locations,
  client_id: System.fetch_env!("FOURSQUARE_CLIENT_ID"),
  client_secret: System.fetch_env!("FOURSQUARE_CLIENT_SECRET")

config :fego, port: String.to_integer(System.fetch_env!("PORT"))
config :ex_gram, token: System.fetch_env!("FEGO_TELEGRAM_TOKEN")
