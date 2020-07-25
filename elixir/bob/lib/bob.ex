defmodule Bob do
  def hey(input) do
    cond do
      String.equivalent?(input, String.upcase(input)) &&
        String.match?(input, ~r/[[:alpha:]]/) &&
          String.ends_with?(input, "?") ->
        "Calm down, I know what I'm doing!"

      String.equivalent?(input, String.upcase(input)) &&
          String.match?(input, ~r/[[:alpha:]]/) ->
        "Whoa, chill out!"

      String.ends_with?(input, "?") ->
        "Sure."

      String.trim(input) == "" ->
        "Fine. Be that way!"

      true ->
        "Whatever."
    end
  end
end
