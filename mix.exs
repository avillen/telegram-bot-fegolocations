defmodule Fego.MixProject do
  use Mix.Project

  def project do
    [
      app: :fego,
      version: "0.1.0",
      elixir: "~> 1.10.3",
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
      {:ex_gram, "~> 0.14"},
      {:tesla, "~> 1.3"},
      {:hackney, "~> 1.16"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.0"},
      # Dev/Test
      {:mox, "~> 0.5", only: :test}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
