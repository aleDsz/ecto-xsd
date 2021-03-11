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
      {:ecto, "~> 3.5", optional: true}
    ]
  end
end
