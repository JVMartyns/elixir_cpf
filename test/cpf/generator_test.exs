defmodule Cpf.GeneratorTest do
  use ExUnit.Case

  describe "generate/0" do
    test "generate a valid cpf" do
      cpf = Cpf.generate()
      assert Cpf.valid?(cpf)
    end
  end

  describe "generate/1" do
    test "generate a formatted cpf" do
      cpf = Cpf.generate(format: true)
      assert String.match?(cpf, ~r/^(\d{3}).(\d{3}).(\d{3})-(\d{2})$/)
    end

    test "select the cpf state" do
      assert cpf_state_digit(Cpf.generate(state: "RS")) == 0
      assert cpf_state_digit(Cpf.generate(state: "DF")) == 1
      assert cpf_state_digit(Cpf.generate(state: "GO")) == 1
      assert cpf_state_digit(Cpf.generate(state: "MS")) == 1
      assert cpf_state_digit(Cpf.generate(state: "TO")) == 1
      assert cpf_state_digit(Cpf.generate(state: "PA")) == 2
      assert cpf_state_digit(Cpf.generate(state: "AM")) == 2
      assert cpf_state_digit(Cpf.generate(state: "AC")) == 2
      assert cpf_state_digit(Cpf.generate(state: "AP")) == 2
      assert cpf_state_digit(Cpf.generate(state: "RO")) == 2
      assert cpf_state_digit(Cpf.generate(state: "RR")) == 2
      assert cpf_state_digit(Cpf.generate(state: "CE")) == 3
      assert cpf_state_digit(Cpf.generate(state: "MA")) == 3
      assert cpf_state_digit(Cpf.generate(state: "PI")) == 3
      assert cpf_state_digit(Cpf.generate(state: "PE")) == 4
      assert cpf_state_digit(Cpf.generate(state: "RN")) == 4
      assert cpf_state_digit(Cpf.generate(state: "PB")) == 4
      assert cpf_state_digit(Cpf.generate(state: "AL")) == 4
      assert cpf_state_digit(Cpf.generate(state: "BA")) == 5
      assert cpf_state_digit(Cpf.generate(state: "SE")) == 5
      assert cpf_state_digit(Cpf.generate(state: "MG")) == 6
      assert cpf_state_digit(Cpf.generate(state: "RJ")) == 7
      assert cpf_state_digit(Cpf.generate(state: "ES")) == 7
      assert cpf_state_digit(Cpf.generate(state: "SP")) == 8
      assert cpf_state_digit(Cpf.generate(state: "PR")) == 9
      assert cpf_state_digit(Cpf.generate(state: "SC")) == 9
    end
  end

  defp cpf_state_digit(cpf) do
    cpf
    |> String.at(8)
    |> String.to_integer()
  end
end
