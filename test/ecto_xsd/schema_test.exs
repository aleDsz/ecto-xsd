defmodule EctoXSD.SchemaTest do
  use ExUnit.Case
  require TemporaryEnv

  alias EctoXSD.Schema
  alias EctoXSD.SchemaTest.TestSchema

  @path "test/fixtures/file.xsd"

  describe "xsd/1" do
    test "it throws an exception when file doesn't exists" do
      assert_raise File.Error, fn ->
        defmodule Foo do
          use Schema

          xsd("test/fixtures/file2.xsd")
        end
      end
    end

    test "it throws an exception when file doesn't have .xsd extension" do
      assert_raise File.Error, fn ->
        defmodule Foo do
          use Schema

          xsd("test/fixtures/file2.ext")
        end
      end
    end
  end

  describe "__xsd__/1" do
    test "it returns the xsd path" do
      defmodule TestSchema do
        use Schema

        xsd("test/fixtures/file.xsd")
      end

      assert @path == TestSchema.__xsd__(:path)
    end
  end
end
