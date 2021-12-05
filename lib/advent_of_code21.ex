defmodule AdventOfCode21 do
  @moduledoc """
  """

  @doc """
  See README, essentially recur through the list and see how many times the measurement
  is more than its previous measurement.
  """
  def day_1_part_1(data \\ AdventOfCode21.InputHelper.read!("day_1_part_1")) do
    data
    |> parse_as_ints()
    |> count_increases()
  end

  def day_1_part_2(data \\ AdventOfCode21.InputHelper.read!("day_1_part_2")) do
    data
    |> parse_as_ints()
    |> map_window(3, &Enum.sum/1)
    |> count_increases()
  end

  def day_2_part_1(data \\ AdventOfCode21.InputHelper.read!("day_2_part_1")) do
    {horizontal, depth} =
      data
      |> to_list()
      |> Enum.map(&parse_instructions/1)
      |> Enum.reduce({0, 0}, fn
        {:forward, amount}, {horizontal, depth} -> {horizontal + amount, depth}
        {:down, amount}, {horizontal, depth} -> {horizontal, depth + amount}
        {:up, amount}, {horizontal, depth} -> {horizontal, depth - amount}
      end)

    horizontal * depth
  end

  @doc """
    down X increases your aim by X units.
    up X decreases your aim by X units.
    forward X does two things:
        It increases your horizontal position by X units.
        It increases your depth by your aim multiplied by X.
  """
  # It's the same input but does something different.
  def day_2_part_2(data \\ AdventOfCode21.InputHelper.read!("day_2_part_1")) do
    {horizontal, depth, _aim} =
      data
      |> to_list()
      |> Enum.map(&parse_instructions/1)
      |> Enum.reduce({0, 0, 0}, fn
        {:forward, amount}, {horizontal, depth, aim} ->
          {horizontal + amount, depth + aim * amount, aim}

        {:down, amount}, {horizontal, depth, aim} ->
          {horizontal, depth, aim + amount}

        {:up, amount}, {horizontal, depth, aim} ->
          {horizontal, depth, aim - amount}
      end)

    horizontal * depth
  end

  defp parse_instructions("forward " <> amount), do: {:forward, String.to_integer(amount)}
  defp parse_instructions("down " <> amount), do: {:down, String.to_integer(amount)}
  defp parse_instructions("up " <> amount), do: {:up, String.to_integer(amount)}

  defp parse_as_ints(data) do
    data
    |> to_list()
    |> Enum.map(&elem(Integer.parse(&1), 0))
  end

  defp to_list(string) do
    string
    |> String.trim()
    |> String.split("\n")
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
