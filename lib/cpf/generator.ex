defmodule Cpf.Generator do
  import Cpf.Formatting

  def generate(opts \\ []) do
    opts[:state]
    |> state()
    |> generate_first_digits()
    |> generate_first_verifying_digit()
    |> generate_second_verifying_digit()
    |> (&if(opts[:format], do: format(&1), else: Enum.join(&1))).()
  end

  defp generate_first_digits(state) do
    Enum.map(0..7, fn _ -> Enum.random(0..9) end) ++ [state]
  end

  defp generate_first_verifying_digit(first_digits) do
    first_digits
    |> Enum.reduce({0, 10}, &{elem(&2, 0) + &1 * elem(&2, 1), elem(&2, 1) - 1})
    # |> Enum.reduce({0, 10}, fn n, {x, y} ->
    #   {x + n * y, y - 1}
    # end)
    |> (&rem(elem(&1, 0), 11)).()
    |> (&if(&1 < 2, do: 0, else: 11 - &1)).()
    |> (&(first_digits ++ [&1])).()
  end

  defp generate_second_verifying_digit(digits) do
    digits
    |> Enum.reduce({0, 11}, fn n, {x, y} ->
      {x + n * y, y - 1}
    end)
    |> (&rem(elem(&1, 0), 11)).()
    |> (&if(&1 < 2, do: 0, else: 11 - &1)).()
    |> (&(digits ++ [&1])).()
  end

  defp state(acronym) do
    cond do
      acronym in ["RS"] ->
        0

      acronym in ["DF", "GO", "MS", "TO"] ->
        1

      acronym in ["PA", "AM", "AC", "AP", "RO", "RR"] ->
        2

      acronym in ["CE", "MA", "PI"] ->
        3

      acronym in ["PE", "RN", "PB", "AL"] ->
        4

      acronym in ["BA", "SE"] ->
        5

      acronym in ["MG"] ->
        6

      acronym in ["RJ", "ES"] ->
        7

      acronym in ["SP"] ->
        8

      acronym in ["PR", "SC"] ->
        9

      true ->
        Enum.random(0..9)
    end
  end
end
