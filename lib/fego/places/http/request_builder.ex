defmodule Fego.Places.Http.RequestBuilder do
  @moduledoc """
  Module to build the Places.Http requests
  """

  def build_query_params,
    do: "?#{secrets_build()}"

  def build_query_params([{key, value}]),
    do: "?#{to_param(key, value)}" <> "&#{secrets_build()}"

  def build_query_params([{key, value} | params]),
    do: "?#{to_param(key, value)}" <> do_build_uri_params(params) <> "&#{secrets_build()}"

  defp do_build_uri_params([]),
    do: ""

  defp do_build_uri_params([{_key, nil}]),
    do: ""

  defp do_build_uri_params([{key, value}]),
    do: "&#{to_param(key, value)}"

  defp do_build_uri_params([{_key, nil} | params]),
    do: build_query_params(params)

  defp do_build_uri_params([{key, value} | params]),
    do: "&#{to_param(key, value)}" <> build_query_params(params)

  defp to_param(key, value), do: "#{Atom.to_string(key)}=#{value}"

  defp v, do: Date.to_iso8601(DateTime.utc_now(), :basic)
  defp client_id, do: Application.get_env(:fego, :locations)[:client_id]
  defp client_secret, do: Application.get_env(:fego, :locations)[:client_secret]
  defp secrets_build, do: "client_id=#{client_id()}&client_secret=#{client_secret()}&v=#{v()}"
end
