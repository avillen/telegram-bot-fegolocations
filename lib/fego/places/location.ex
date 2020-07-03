defmodule Fego.Places.Location do
  @moduledoc """
  Struct that wraps a location
  """

  @type category_name :: String.t()
  @type lat :: float()
  @type lng :: float()
  @type name :: String.t()

  @type t :: %__MODULE__{
          category_name: category_name,
          lat: lat,
          lng: lng,
          name: name
        }

  defstruct ~w(
    category_name
    lat
    lng
    name
  )a
end
