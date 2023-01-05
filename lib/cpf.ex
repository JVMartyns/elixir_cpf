defmodule Cpf do
  alias __MODULE__.{
    Formatting,
    Generator,
    Validation
  }

  defdelegate valid?(cpf), to: Validation
  defdelegate generate(opts \\ []), to: Generator
  defdelegate format(cpf), to: Formatting
  defdelegate clear(cpf), to: Formatting
end
