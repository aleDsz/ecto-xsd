defmodule EctoXSD do
  @moduledoc """
  # EctoXSD

  EctoXSD is a library which provides a nice interface to build
  XML Schemas using [Ecto](https://github.com/elixir-ecto/ecto)
  and provides a way to validate the element with his
  equivalent XSD.
  """

  @typep system_env() :: {:system, binary()}
  @typep configuration :: [] | keyword(binary() | system_env())

  @doc """
  Gets the XSD Paths configuration
  """
  @spec get_config() :: configuration()
  def get_config do
    Application.get_env(:ecto_xsd, :xsd_paths, [])
  end
end
