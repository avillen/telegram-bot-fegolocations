defmodule Fego.EndpointTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts Fego.Endpoint.init([])

  test "it returns pong" do
    conn = conn(:get, "/ping")

    conn = Fego.Endpoint.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "pong!"
  end
end
