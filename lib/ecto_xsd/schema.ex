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

  @doc false
  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema
      import EctoXSD.Schema, only: [xsd: 1]

      @before_compile EctoXSD.Schema
      @primary_key false
    end
  end

  @doc false
  defmacro __before_compile__(_env) do
    quote do
      def __xsd__(:path), do: @ecto_xsd_path
    end
  end

  @doc false
  defmacro xsd(xsd_path) do
    __xsd__(xsd_path)
  end

  defp __xsd__(xsd_path) do
    postlude =
      quote do
        Module.register_attribute(__MODULE__, :ecto_xsd_path, accumulate: false)

        xsd_path =
          case unquote(xsd_path) do
            xsd_path when is_binary(xsd_path) ->
              xsd_path

            xsd_config when is_atom(xsd_config) ->
              EctoXSD.get_config(xsd_config)
          end

        path =
          with {:file, true} <- {:file, File.exists?(xsd_path)},
               {:extension, true} <- {:extension, String.ends_with?(xsd_path, ".xsd")} do
            xsd_path
          else
            {:file, false} ->
              raise File.Error, path: xsd_path, action: "exists?", reason: "doesn't exists"

            {:extension, false} ->
              raise File.Error,
                path: xsd_path,
                action: "correct extension?",
                reason: "doesn't have .xsd extension"
          end

        Module.put_attribute(__MODULE__, :ecto_xsd_path, path)
      end

    quote do
      unquote(postlude)
    end
  end
end
