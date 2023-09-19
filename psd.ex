defmodule PasswordGenerator do
  @number_chars "0123456789"
  @symbol_chars "!@#$%^&*()_+-=[]{}|;:'\",.<>/?"
  @uppercase_chars "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

  def generate_password(number, symbol, uppercase, length) when is_boolean(number) and is_boolean(symbol) and is_boolean(uppercase) and is_integer(length) and length > 0 do

    alphabet = build_alphabet(number, symbol, uppercase)

    if length <= String.length(alphabet) do
      password = generate_password_recursive(alphabet, length, "")
      {:ok, password}
    else
      {:error, "Invalid parameter types. Please ensure that number, uppercase, and symbol are booleans, and length is an integer."}
    end
  end

  defp build_alphabet(number, symbol, uppercase) do
    alphabet =
      (if number, do: @number_chars, else: "") <>
      (if symbol, do: @symbol_chars, else: "") <>
      (if uppercase, do: @uppercase_chars, else: "")

    alphabet
  end

  defp generate_password_recursive(_, 0, password) do
    password
  end
  defp generate_password_recursive(alphabet, length, password) do
    random_index = :rand.uniform(String.length(alphabet))
    random_char = String.at(alphabet, random_index)
    IO.puts(random_char)
    generate_password_recursive(alphabet, length - 1, password <> random_char)
  end
end

{:ok, password} = PasswordGenerator.generate_password(true, true, false, 20)
IO.puts(password)

{:error, error_message} = PasswordGenerator.generate_password(false, false, false, 8)
IO.puts(error_message)
