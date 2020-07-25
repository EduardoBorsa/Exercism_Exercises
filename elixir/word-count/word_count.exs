defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """

  def count(sentence) when is_binary(sentence) do
    sentence
    |> String.downcase()
    |> String.split(~r/(?![a-zA-Z0-9\-äöüÄÖÜß])./ui, trim: true)
    |> count()
  end

  def count(sentence) when is_list(sentence) do
    Enum.reduce(sentence, %{}, fn el, acc ->
      Map.update(acc, el, 1, &(&1 + 1))
    end)
  end
end
