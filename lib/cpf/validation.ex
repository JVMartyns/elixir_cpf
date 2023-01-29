defmodule Cpf.Validation do
  def valid?(cpf) when is_integer(cpf) do
    cpf
    |> Integer.digits()
    |> validate()
  end

  def valid?(cpf) when is_binary(cpf) do
    cpf
    |> String.replace(~r/\D/, "")
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> validate()
  rescue
    _ -> false
  end

  def valid?(cpf) when is_list(cpf) do
    validate(cpf)
  rescue
    _ -> false
  end

  def valid?(_), do: false

  defp validate(cpf) when length(cpf) != 11, do: false

  defp validate(cpf) do
    with true <- not is_sequence?(cpf),
         true <- validate_first_verifying_digit(cpf) do
      validate_second_verifying_digit(cpf)
    end
  end

  defp is_sequence?(cpf) do
    Enum.all?(cpf, fn num ->
      num == Enum.at(cpf, Enum.find_index(cpf, &(&1 == num)) + 1)
    end)
  end

  defp validate_first_verifying_digit(cpf) do
    cpf
    |> Enum.slice(0..8)
    |> Enum.reduce({0, 10}, fn n, {x, y} ->
      {x + n * y, y - 1}
    end)
    |> (&(rem(elem(&1, 0) * 10, 11) in [Enum.at(cpf, 9), 10])).()
  end

  defp validate_second_verifying_digit(cpf) do
    cpf
    |> Enum.slice(0..9)
    |> Enum.reduce({0, 11}, fn n, {x, y} ->
      {x + n * y, y - 1}
    end)
    |> (&(rem(elem(&1, 0) * 10, 11) in [Enum.at(cpf, 10), 10])).()
  end
end
