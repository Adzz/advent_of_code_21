defmodule AdventOfCode21.Day3 do
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

  Also no effort to speed things up here. We should probably use a bit mask as I presume
  that the epsilon is like the bnot of the gamma or something.
  """
  def day_3_part_1(data \\ AdventOfCode21.InputHelper.read!("day_3_part_1")) do
    {gamma, epsilon} =
      data
      |> AdventOfCode21.InputHelper.to_list()
      |> Enum.map(&String.graphemes/1)
      |> Enum.zip_reduce({"", ""}, fn items, {gamma, epsilon} ->
        %{"0" => zero_count, "1" => one_count} = Enum.frequencies(items)

        gamma_digit = if zero_count > one_count, do: 0, else: 1
        epsilon_digit = flip_the_bit(gamma_digit)

        {gamma <> "#{gamma_digit}", epsilon <> "#{epsilon_digit}"}
      end)

    String.to_integer(gamma, 2) * String.to_integer(epsilon, 2)
  end

  def day_3_part_2(data \\ AdventOfCode21.InputHelper.read!("day_3_part_1")) do
    list = data |> AdventOfCode21.InputHelper.to_list() |> Enum.map(&String.graphemes/1)

    oxygen_bit_selector = fn zero_count, one_count ->
      if zero_count > one_count, do: "0", else: "1"
    end

    co2_bit_selector = fn zero_count, one_count ->
      if zero_count > one_count, do: "1", else: "0"
    end

    column = hd(Enum.zip_with(list, & &1))
    oxygen = interpret(list, 0, column, oxygen_bit_selector)
    co2 = interpret(list, 0, column, co2_bit_selector)

    oxygen * co2
  end

  defp interpret(rows, column_index, column, bit_selector) do
    %{"0" => zero_count, "1" => one_count} = Enum.frequencies(column)
    selected_bit = bit_selector.(zero_count, one_count)

    rows
    |> Enum.filter(fn row ->
      Enum.at(row, column_index) == selected_bit
    end)
    |> case do
      [remain] ->
        remain |> Enum.join() |> String.to_integer(2)

      remaining ->
        interpret(
          remaining,
          column_index + 1,
          Enum.at(Enum.zip_with(remaining, & &1), column_index + 1),
          bit_selector
        )
    end
  end

  def flip_the_bit(bit), do: 1 - bit
end
