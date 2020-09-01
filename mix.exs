defmodule Fego.MixProject do
  use Mix.Project

  def project do
    [
      app: :fego,
      version: "0.1.0",
      elixir: "~> 1.10.4",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Fego.Application, []}
    ]
  end

  defp deps do
    [
      {:ex_gram, "~> 0.14.0"},
      {:tesla, "~> 1.3.3"},
      {:hackney, "~> 1.16.0"},
      {:jason, "~> 1.2.1"},
      {:plug_cowboy, "~> 2.3.0"},
      # Dev/Test
      {:mox, "~> 0.5.2", only: :test}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
