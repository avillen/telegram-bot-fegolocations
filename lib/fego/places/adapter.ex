defmodule Fego.Places.Adapter do
  @moduledoc """
  Places behaviour
  """

  alias Fego.Places.Location

  @callback start_link(Keyword.t()) :: GenServer.on_start()

  @type lat :: float()
  @type lng :: float()
  @type location :: String.t()
  @type limit :: integer()

  @type locations :: [Location.t()]

  @callback fetch_by_near(location, limit) :: {:ok, locations} | :error
  @callback fetch_by_location(lat, lng, limit) :: {:ok, locations} | :error
end
