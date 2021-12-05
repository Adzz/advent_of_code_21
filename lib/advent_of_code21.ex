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
      |> parse_instructions()
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
      |> parse_instructions()
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

  @doc """
  We have a matrix and we need to find the most and least common bit in each column, then
  make a number out of it. The most common bit == Gamma, least == Epsilon
      [
        [0,0,1,0,0],
        [1,1,1,1,0],
        [1,0,1,1,0],
      ]
  So here Gamma == 10110, epsilon == 01100

  Not actually clear if all the columns are the same what to do, or what to do if they are
  equal? Assume they wont be? 🤷‍♂️

  Also no effort to speed things up here.
  """
  def day_3_part_1(data \\ AdventOfCode21.InputHelper.read!("day_3_part_1")) do
    {gamma, epsilon} =
      data
      |> to_list()
      # We make it a list of strings to let us use enum. Could implement a String.zip instead.
      |> Enum.map(&String.graphemes/1)
      |> Enum.zip_reduce({[], []}, fn items, {gamma, epsilon} ->
        %{"0" => zero_count, "1" => one_count} = Enum.frequencies(items)

        gamma_digit = if zero_count > one_count, do: 0, else: 1
        epsilon_digit = if zero_count > one_count, do: 1, else: 0

        {[gamma_digit | gamma], [epsilon_digit | epsilon]}
      end)

    to_base_10_int(:lists.reverse(gamma)) * to_base_10_int(:lists.reverse(epsilon))
  end

  def day_3_part_2(data \\ AdventOfCode21.InputHelper.read!("day_3_part_1")) do
    data
  end

  defp to_base_10_int(charlist) do
    charlist
    |> Enum.join()
    |> String.to_integer(2)
  end

  def parse_instructions(instructions) do
    Enum.map(instructions, fn
      "forward " <> amount -> {:forward, String.to_integer(amount)}
      "down " <> amount -> {:down, String.to_integer(amount)}
      "up " <> amount -> {:up, String.to_integer(amount)}
    end)
  end

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
