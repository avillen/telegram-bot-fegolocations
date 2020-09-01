defmodule Fego.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: Fego.Endpoint,
        options: [port: Application.get_env(:fego, :port)]
      ),
      ExGram,
      {Fego, [method: :polling, token: fetch_telegram_token()]}
    ]

    opts = [strategy: :one_for_one, name: Fego.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp fetch_telegram_token, do: Application.get_env(:ex_gram, :token)
end
