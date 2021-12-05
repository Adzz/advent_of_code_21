defmodule AdventOfCode21 do
  @moduledoc """
  """

  @doc """
  See README, essentially recur through the list and see how many times the measurement
  is more than its previous measurement.
  """
  def day_1_part_1(data \\ AdventOfCode21.InputHelper.read!("day_1")) do
    data
    |> parse_as_ints()
    |> count_increases()
  end

  def day_1_part_2(data \\ AdventOfCode21.InputHelper.read!("day_2")) do
    data
    |> parse_as_ints()
    |> map_window(3, &Enum.sum/1)
    |> count_increases()
  end

  defp parse_as_ints(data) do
    data
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&elem(Integer.parse(&1), 0))
  end

  @doc """
  Counts the how many times the previous element is less than the next element in a list.
  Iterates two at a time.
  """
  def count_increases(list) do
    reduce_window(list, 2, 0, fn [prev, next], count ->
      if prev < next, do: count + 1, else: count
    end)
  end

  @doc """
  Maps through a list N at a time passing N elements to the mapping function and creating
  a new list out of the results of those calls.
  """
  def map_window(list, window_size, mapper) when is_list(list) do
    reduce_window(list, window_size, [], fn items, acc ->
      [mapper.(items) | acc]
    end)
    |> :lists.reverse()
  end

  @doc """
  Reduces over a list N at a time.
  """
  def reduce_window(list, window_size, acc, reducer) do
    if length(list) < window_size do
      acc
    else
      {tooken, rest} = Enum.split(list, window_size)
      rest = Enum.drop(tooken, 1) ++ rest
      reduce_window(rest, window_size, reducer.(tooken, acc), reducer)
    end
  end
end
