defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    filter(list, fun, [])   
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
   filter(list, &(not fun.(&1)), [])
  end

  defp filter([], _fun, acc), do: acc |> Enum.reverse()
  defp filter([h | _t] = list, fun, acc), do: filter(list, fun, acc, fun.(h))
  
  defp filter([h | t], fun, acc, res?) when res? do
    filter(t, fun, [h | acc])
  end
  defp filter([_h | t], fun, acc, _res) do 
    filter(t, fun, acc)
  end
end
