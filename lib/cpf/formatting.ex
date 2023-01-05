defmodule Cpf.Formatting do
  import Cpf.Validation

  @valid_format ~r/^(\d{3}).(\d{3}).(\d{3})-(\d{2})$/

  def clear(cpf) when is_binary(cpf), do: String.replace(cpf, ~r/\D/, "")

  def format(cpf) when is_binary(cpf) do
    cond do
      String.match?(cpf, @valid_format) -> cpf
      valid?(cpf) -> format(binary_to_list(cpf))
      true -> :error
    end
  end

  def format(cpf) when is_integer(cpf) do
    with true <- valid?(cpf) do
      cpf
      |> Integer.digits()
      |> format()
    else
      _ -> :error
    end
  end

  def format(cpf) when is_list(cpf) do
    with true <- valid?(cpf) do
      cpf
      |> List.insert_at(3, ".")
      |> List.insert_at(7, ".")
      |> List.insert_at(11, "-")
      |> Enum.join()
    else
      _ -> :error
    end
  end

  def format(_), do: :error

  defp binary_to_list(cpf) do
    cpf
    |> String.to_integer()
    |> Integer.digits()
  end
end
