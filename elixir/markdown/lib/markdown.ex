defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(input) do
    String.split(input, "\n")
    |> Enum.map_join("", &process/1)
    |> to_unordered_list()
  end

  defp process(line = "#" <> _) do
    line
    |> parse_header_md_level()
    |> enclose_with_header_tag()
  end

  defp process(line = "*" <> _) do
    line
    |> parse_list_md_level()
  end

  defp process(line) do
    line
    |> String.split()
    |> enclose_with_paragraph_tag()
  end

  defp parse_header_md_level(line) do
    [first_word | other_words] = String.split(line)
    header_level = to_string(String.length(first_word))
    line_content = Enum.join(other_words, " ")
    {header_level, line_content}
  end

  defp parse_list_md_level(line) do
    words =
      line
      |> String.trim_leading("* ")
      |> String.split(" ")

    "<li>#{join_words_with_tags(words)}</li>"
  end

  defp enclose_with_header_tag({header_level, line_content}) do
    "<h#{header_level}>#{line_content}</h#{header_level}>"
  end

  defp enclose_with_paragraph_tag(t) do
    "<p>#{join_words_with_tags(t)}</p>"
  end

  defp join_words_with_tags(words) do
    words
    |> Enum.map(&replace_md_with_tag(&1))
    |> Enum.join(" ")
  end

  defp replace_md_with_tag(word) do
    word
    |> replace_prefix_md()
    |> replace_suffix_md()
  end

  defp replace_prefix_md(word) do
    cond do
      String.starts_with?(word, "__") ->
        String.replace(word, "__", "<strong>", global: false)

      String.starts_with?(word, "_") ->
        String.replace(word, "_", "<em>", global: false)

      true ->
        word
    end
  end

  defp replace_suffix_md(word) do
    cond do
      String.ends_with?(word, "__") ->
        String.replace(word, "__", "</strong>")

      String.ends_with?(word, "_") ->
        String.replace(word, "_", "</em>")

      true ->
        word
    end
  end

  defp to_unordered_list(line) do
    String.replace(line, "<li>", "<ul>" <> "<li>", global: false)
    |> String.replace_suffix("</li>", "</li>" <> "</ul>")
  end
end
