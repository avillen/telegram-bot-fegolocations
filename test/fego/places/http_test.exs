defmodule Fego.Places.HttpTest do
  use ExUnit.Case

  alias Fego.Places.Http.RequestBuilder

  alias Fego.Places.{
    Http,
    Location,
    Mock
  }

  import Mox

  @base_url "https://api.foursquare.com/v2/venues"

  describe "fetch_by_near/2" do
    test "success" do
      location = "madrid"
      limit = 3
      query_params = RequestBuilder.build_query_params(near: URI.encode(location), limit: limit)
      url = @base_url <> "/explore" <> query_params

      Mock
      |> expect(:call, fn
        %{method: :get, url: ^url}, _opts ->
          response = %{
            "response" => %{
              "groups" => [
                %{
                  "items" => [
                    %{
                      "venue" => %{
                        "name" => "venue_name",
                        "location" => %{"lat" => 1.0, "lng" => 2.0},
                        "categories" => [%{"name" => "category_name"}]
                      }
                    }
                  ]
                }
              ]
            }
          }

          {:ok, %Tesla.Env{status: 200, body: response}}
      end)

      response = [
        %Location{
          category_name: "category_name",
          lat: 1.0,
          lng: 2.0,
          name: "venue_name"
        }
      ]

      assert {:ok, response} == Http.fetch_by_near(location, limit)
    end

    test "error" do
      location = "madrid"
      limit = 3
      query_params = RequestBuilder.build_query_params(near: URI.encode(location), limit: limit)
      url = @base_url <> "/explore" <> query_params

      Mock
      |> expect(:call, fn
        %{method: :get, url: ^url}, _opts ->
          {:ok, %Tesla.Env{status: 500, body: ""}}
      end)

      assert :error == Http.fetch_by_near(location, limit)
    end
  end

  describe "fetch_by_location/2" do
    test "success" do
      lat = 1.0
      lng = 1.0
      limit = 3

      query_params =
        RequestBuilder.build_query_params(ll: URI.encode("#{lat},#{lng}"), limit: limit)

      url = @base_url <> "/explore" <> query_params

      Mock
      |> expect(:call, fn
        %{method: :get, url: ^url}, _opts ->
          response = %{
            "response" => %{
              "groups" => [
                %{
                  "items" => [
                    %{
                      "venue" => %{
                        "name" => "venue_name",
                        "location" => %{"lat" => 1.0, "lng" => 2.0},
                        "categories" => [%{"name" => "category_name"}]
                      }
                    }
                  ]
                }
              ]
            }
          }

          {:ok, %Tesla.Env{status: 200, body: response}}
      end)

      response = [
        %Location{
          category_name: "category_name",
          lat: 1.0,
          lng: 2.0,
          name: "venue_name"
        }
      ]

      assert {:ok, response} == Http.fetch_by_location(lat, lng, limit)
    end

    test "error" do
      lat = 1.0
      lng = 1.0
      limit = 3

      query_params =
        RequestBuilder.build_query_params(ll: URI.encode("#{lat},#{lng}"), limit: limit)

      url = @base_url <> "/explore" <> query_params

      Mock
      |> expect(:call, fn
        %{method: :get, url: ^url}, _opts ->
          {:ok, %Tesla.Env{status: 500, body: ""}}
      end)

      assert :error == Http.fetch_by_location(lat, lng, limit)
    end
  end
end
