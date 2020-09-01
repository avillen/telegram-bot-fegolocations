import Config

config :tesla, Fego.Places.Http, adapter: Tesla.Adapter.Hackney
config :fego, :locations, url: "localhost"

import_config "#{Mix.env()}.exs"
