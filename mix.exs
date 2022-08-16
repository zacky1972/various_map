defmodule VariousMap.MixProject do
  use Mix.Project

  def project do
    [
      app: :various_map,
      version: "0.1.0-dev",
      elixir: "~> 1.14-rc",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "VariousMap",
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:ex_doc, "~> 0.28", only: :dev, runtime: false},
      {:benchee, "~> 1.1", only: :dev}
    ]
  end

  defp docs do
    [
      main: "README",
      extras: ["README.md"]
    ]
  end
end
