defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(input) do
    input
    |> to_rna([])
  end

  def to_rna([], answer), do: answer

  def to_rna([?G | t], answer) do
    to_rna(t, answer ++ [?C])
  end

  def to_rna([?C | t], answer) do
    to_rna(t, answer ++ [?G])
  end

  def to_rna([?T | t], answer) do
    to_rna(t, answer ++ [?A])
  end

  def to_rna([?A | t], answer) do
    to_rna(t, answer ++ [?U])
  end
end
