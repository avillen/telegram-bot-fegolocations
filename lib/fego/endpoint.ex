defmodule Fego.Endpoint do
  @moduledoc """
  A Plug responsible for logging request info, parsing request body's as JSON,
  matching routes, and dispatching responses.
  """

  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)
  plug(:dispatch)

  get "/ping" do
    send_resp(conn, 200, "pong!")
  end

  match _ do
    send_resp(conn, 404, "oops... Nothing here :(")
  end
end
