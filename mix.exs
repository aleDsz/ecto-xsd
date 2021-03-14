defmodule EctoXSD.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_xsd,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto, "~> 3.5", optional: true},
      {:temporary_env, "~> 2.0", optional: true, only: :test},
      {:credo, "~> 1.5.0", optional: true, only: :test, runtime: false},
      {:excoveralls, "~> 0.10", optional: true, only: :test},
      {:git_hooks, "~> 0.5.0", optional: true, only: :test, runtime: false}
    ]
  end
end
