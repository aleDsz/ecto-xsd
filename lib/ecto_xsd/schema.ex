defmodule EctoXSD.Schema do
  @moduledoc """
  ```
  defmodule MyApp.Users.User do
    use EctoXSD.Schema

    schema "XMLNode" do
      field :name, :string, source: :PersonName
      field :age, :integer, source: :PersonAge
    end
  end
  ``` 
  """
  import EctoXSD

  @doc false
  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema

      @before_compile Ecto.XSD
      @primary_key false

      Module.put_attribute(__MODULE__, :ecto_xsd_path, nil)
    end
  end

  @doc false
  defmacro __before_compile__(_, _) do
    quote do
      require EctoXSD.Schema

      def __xsd__(:path), do: @ecto_xsd_path
    end
  end

  @doc false
  defmacro xsd(xsd_path) do
    with {:ok, path} <- __xsd__(xsd_path) do
      Module.put_attribute(__MODULE__, :ecto_xsd_path, path)
    end
  end

  defp __xsd__(xsd_config) when is_atom(xsd_config) do
    get_config(xsd_config)
    |> validate_xsd_path()
  end

  defp __xsd__(xsd_path) when is_binary(xsd_path) do
    validate_xsd_path(xsd_path)
  end

  defp validate_xsd_path(xsd_path) when is_binary(xsd_path) do
    with true <- File.exists?(xsd_path),
         true <- String.ends_with?(xsd_path, ".xsd") do
      xsd_path
    else
      _ ->
        raise raise_path()
    end
  end

  defp raise_path do
    """
    Raise this
    """
  end
end
