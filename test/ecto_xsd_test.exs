defmodule EctoXSDTest do
  use ExUnit.Case
  require TemporaryEnv

  @path "/fakepath/file.xsd"
  @string_value [foo: @path]
  @tuple_value [foo: {:system, "XSD_PATH"}]

  describe "get_config/0" do
    test "it returns an empty keyword list" do
      assert [] == EctoXSD.get_config()
    end

    test "it returns an keyword list with string value" do
      TemporaryEnv.put :ecto_xsd, :xsd_paths, @string_value do
        assert @string_value == EctoXSD.get_config()
      end
    end

    test "it returns an keyword list with tuple" do
      TemporaryEnv.put :ecto_xsd, :xsd_paths, @tuple_value do
        assert @tuple_value == EctoXSD.get_config()
      end
    end
  end

  describe "get_config/1" do
    setup do
      :ok = System.put_env("XSD_PATH", @path)
      :ok
    end

    test "it throws an exception when key doesn't exists" do
      assert_raise KeyError, "key :bar not found in: []", fn ->
        EctoXSD.get_config(:bar)
      end
    end

    test "it returns an keyword list with string value" do
      TemporaryEnv.put :ecto_xsd, :xsd_paths, @string_value do
        assert @path == EctoXSD.get_config(:foo)
      end
    end

    test "it returns an keyword list with tuple" do
      TemporaryEnv.put :ecto_xsd, :xsd_paths, @tuple_value do
        assert @path == EctoXSD.get_config(:foo)
      end
    end
  end
end
