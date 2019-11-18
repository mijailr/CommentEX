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
      name: "Comment",
      package: package(),
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.html": :test,
        docs: :dev
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
      applications: [
        :tentacat
      ],
      extra_applications: [
        :crypto,
        :plug_cowboy,
        :logger
      ]
    ]
  end

  defp deps do
    [
      {:tentacat, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:json, "~> 1.2"},

      # Test dependencies
      {:credo, "~> 1.1.5", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.7", only: [:dev], runtime: false},
      {:excoveralls, "~> 0.12", only: :test},

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
