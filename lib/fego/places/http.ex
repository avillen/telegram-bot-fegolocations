defmodule Fego.Places.Http do
  @moduledoc """
  Http module to fetch Locations
  """

  use Tesla

  alias __MODULE__.{Parser, RequestBuilder}

  require Logger

  @base_url Application.get_env(:fego, :locations)[:url]

  plug(Tesla.Middleware.BaseUrl, @base_url)
  plug(Tesla.Middleware.JSON)

  @behaviour Fego.Places.Adapter

  @impl true
  def start_link(_opts), do: :ignore

  @impl true
  def fetch_by_near(location, limit) do
    query_params = RequestBuilder.build_query_params(near: URI.encode(location), limit: limit)

    case get("/explore" <> query_params) do
      {:ok, %{body: body, status: 200}} ->
        {:ok, Parser.decode_all_recomendations(body)}

      reason ->
        Logger.error(inspect(reason))
        :error
    end
  end

  @impl true
  def fetch_by_location(lat, lng, limit) do
    location = URI.encode("#{lat},#{lng}")
    query_params = RequestBuilder.build_query_params(ll: location, limit: limit)

    case get("/explore" <> query_params) do
      {:ok, %{body: body, status: 200}} ->
        {:ok, Parser.decode_all_recomendations(body)}

      reason ->
        Logger.error(inspect(reason))
        :error
    end
  end
end
