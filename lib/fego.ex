defmodule Fego do
  @moduledoc """
  Fego bot
  """

  @bot :Fego

  use ExGram.Bot, name: @bot

  alias Fego.Places.Http, as: Places

  middleware(ExGram.Middleware.IgnoreUsername)

  def bot, do: @bot

  def handle({:command, "search", search_text}, context) do
    case Places.fetch_by_near(search_text.text, 10) do
      {:ok, locations} -> answer(context, build_response(locations), parse_mode: "markdown")
      :error -> answer(context, "Nothing :_(")
    end
  end

  def handle({:location, %{latitude: lat, longitude: lng}}, context) do
    case Places.fetch_by_location(lat, lng, 10) do
      {:ok, locations} -> answer(context, build_response(locations), parse_mode: "markdown")
      :error -> answer(context, "Nothing :_(")
    end
  end

  def handle({:command, _command, _msg}, context) do
    answer(context, build_help(), parse_mode: "markdown")
  end

  def handle({:text, _text, _message}, context) do
    answer(context, build_help(), parse_mode: "markdown")
  end

  defp build_help do
    """
    *FEGO*
    - /search madrid
    - Send your position
    """
  end

  defp build_response(locations) do
    Enum.join(Enum.map(locations, &location_to_string/1), "")
  end

  defp location_to_string(%{
         category_name: category_name,
         lat: lat,
         lng: lng,
         name: name
       }) do
    """
    *#{String.upcase(name)}*
    - *#{category_name}*
    - [Location](https://maps.google.com/?q=#{Float.to_string(lat)},#{Float.to_string(lng)})

    """
  end
end
