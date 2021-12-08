defmodule AdventOfCode21.Day2 do
  def day_2_part_1(data \\ AdventOfCode21.InputHelper.read!("day_2_part_1")) do
    {horizontal, depth} =
      data
      |> AdventOfCode21.InputHelper.to_list()
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
      |> AdventOfCode21.InputHelper.to_list()
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

  def parse_instructions(instructions) do
    Enum.map(instructions, fn
      "forward " <> amount -> {:forward, String.to_integer(amount)}
      "down " <> amount -> {:down, String.to_integer(amount)}
      "up " <> amount -> {:up, String.to_integer(amount)}
    end)
  end
end
