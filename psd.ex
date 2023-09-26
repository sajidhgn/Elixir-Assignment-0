defmodule PasswordGeneratorFun do
  @number_chars "0123456789"
  @uppercase_chars "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  @symbol_chars "!@#$%^&*()_+-=[]{}|;:'\",.<>/?\\"


  def genbox (%{"length_field" => length_field, "number_field" => number_field, 
  "uppercase_field" => uppercase_field, "symbol_field" => symbol_field}) do

    length = length_field |> String.to_integer()
    number = if number_field=="true", do: "true", else: ""
    uppercase = if uppercase_field=="true", do: "true", else: ""
    symbol = if symbol_field=="true", do: "true", else: ""

     charset =
      [
        (if String.length(symbol) > 0, do: @symbol_chars, else: ""),
        (if String.length(uppercase) > 0, do: @uppercase_chars, else: ""),
        (if String.length(number) > 0, do: @number_chars, else: "")
      ]
      |> Enum.filter(&(&1 != ""))
      |> Enum.join()

       char_list = String.graphemes(charset)

        password = Enum.reduce(1..length, "", fn _i, acc ->
        char = Enum.random(char_list)
        acc <> char
      end)

      IO.puts(password)
  end
end

PasswordGeneratorFun.genbox(%{"length_field" => "12", "number_field" => "false", 
  "uppercase_field" => "true", "symbol_field" => "true"})
