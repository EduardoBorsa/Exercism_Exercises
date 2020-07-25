defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count([]), do: 0

  def count(l) do
    count(l, 0)
  end

  def count([], count), do: count

  def count([_h | t], count) do
    count(t, count + 1)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    reverse(l, [])
  end

  def reverse([], inverted), do: inverted

  def reverse([h | t], inverted) do
    reverse(t, [h | inverted])
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    map(l, f, [])
  end

  def map([], _f, output), do: reverse(output)

  def map([h | t], f, output) do
    map(t, f, [f.(h) | output])
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    filter(l, f, [])
  end

  def filter([], _f, output), do: reverse(output)

  def filter([h | t], f, output) do
    case f.(h) do
      true ->
        filter(t, f, [h | output])

      _ ->
        filter(t, f, output)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _f), do: acc

  def reduce([h | t], acc, f) do
    reduce(t, f.(h, acc), f)
  end

  @spec append(list, list) :: list
  def append([], b), do: b
  def append(a, []), do: a

  def append(a, b) do
    append(reverse(a), b, [])
  end

  def append([], b, []), do: b

  def append([h | t], b, []) do
    append(t, [h | b], [])
  end

  @spec concat([[any]]) :: [any]
  def concat([]), do: []

  def concat(l) do
    reverse(l)
    |> concat([])
  end

  def concat([], acc), do: acc

  def concat([h | t], acc) do
    concat(t, append(h, acc))
  end
end
