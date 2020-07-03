defmodule Fego.Places.Http.Parser do
  @moduledoc """
  Module to parse the Places.Http responses
  """

  alias Fego.Places.Location

  def decode_all_recomendations(%{
        "response" => %{
          "groups" => [%{"items" => venues}]
        }
      }) do
    Enum.map(venues, &decode_location/1)
  end

  defp decode_location(%{
         "venue" => %{
           "name" => name,
           "location" => %{"lat" => lat, "lng" => lng},
           "categories" => [%{"name" => category_name}]
         }
       }) do
    %Location{
      category_name: category_name,
      lat: lat,
      lng: lng,
      name: name
    }
  end
end
