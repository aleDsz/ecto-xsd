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
end
