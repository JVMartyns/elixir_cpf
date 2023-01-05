defmodule Cpf.ValidationTest do
  use ExUnit.Case
  doctest Cpf

  describe "valid?/1" do
    test "when the cpf is an valid string" do
      assert Cpf.valid?("48682477270")
    end

    test "when the cpf is an valid integer" do
      assert Cpf.valid?(48_682_477_270)
    end

    test "when the cpf is an valid list" do
      assert Cpf.valid?([4, 8, 6, 8, 2, 4, 7, 7, 2, 7, 0])
    end

    test "when the cpf is an invalid string" do
      refute Cpf.valid?("12345678910")
    end

    test "when the cpf is an sequence" do
      refute Cpf.valid?("11111111111")
    end

    test "when the cpf is an invalid integer" do
      refute Cpf.valid?(12_345_678_910)
    end

    test "when the cpf is an invalid list" do
      refute Cpf.valid?([1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 0])
    end
  end
end
