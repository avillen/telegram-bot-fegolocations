import Config

config :fego, :locations,
  client_id: System.get_env("FOURSQUARE_CLIENT_ID"),
  client_secret: System.get_env("FOURSQUARE_CLIENT_SECRET"),
  url: "https://api.foursquare.com/v2/venues"

config :tesla, Fego.Places.Http, adapter: Tesla.Adapter.Hackney

config :fego, port: String.to_integer(System.get_env("PORT") || "4000")

import_config "#{Mix.env()}.exs"
