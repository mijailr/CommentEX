defmodule Comment.MixProject do
  use Mix.Project

  @version "0.0.1"

  def project do
    [
      app: :comment,
      deps: deps(),
      description: description(),
      docs: docs(),
      elixir: "~> 1.9",
      elixirc_paths: elixirc_paths(Mix.env()),
      name: "Comment",
      package: package(),
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.html": :test,
        docs: :dev,
        vcr: :test,
        "vcr.delete": :test,
        "vcr.check": :test,
        "vcr.show": :test
      ],
      releases: releases(),
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      version: @version
    ]
  end

  def application do
    [
      mod: {Comment, []},
      extra_applications: [
        :crypto,
        :ecto,
        :logger,
        :plug_cowboy,
        :tentacat
      ]
    ]
  end

  defp elixirc_paths(:test) do
    ["lib", "test/support"]
  end

  defp elixirc_paths(_) do
    ["lib"]
  end

  defp deps do
    [
      {:askimet_ex, "~> 0.1.1"},
      {:ecto_sql, "~> 3.2"},
      {:joken, "~> 2.2"},
      {:plug_cowboy, "~> 2.1"},
      {:postgrex, "~> 0.15"},
      {:tentacat, "~> 1.0"},

      # Test dependencies
      {:credo, "~> 1.1.5", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.7", only: [:dev], runtime: false},
      {:ex_machina, "~> 2.3", only: :test},
      {:excoveralls, "~> 0.12", only: :test},
      {:faker, "~> 0.13", only: :test},

      # Docs dependencies
      {:ex_doc, "~> 0.21", only: :dev}
    ]
  end

  defp description do
    "An static web comments generator privacy focused"
  end

  defp docs do
    [
      extras: ["README.md"],
      main: "readme",
      source_ref: "v#{@version}",
      source_url: "https://github.com/mijailr/CommentEX"
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Mijail Rondon"],
      licenses: ["MIT"],
      links: %{github: "https://github.com/mijailr/CommentEX"}
    ]
  end

  defp releases do
    [
      production: [
        include_executables_for: [:unix],
        applications: [runtime_tools: :permanent]
      ]
    ]
  end
end
