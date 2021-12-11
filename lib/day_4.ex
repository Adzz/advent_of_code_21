defmodule AdventOfCode21.Day4 do
  @doc """
  It's bingo the first line of the input is the numbers called the rest are the boards.

  Once someone has won we sum the numbers not called on the winning board then times by
  the last number that was called. Boom.

  Boards are always 5 X 5 grids.

  So let's pick a sensible  data structure.. a map right?
  Winning things are rows and columns, so if we have a map for each then..

  """
  def day_4_part_1(data \\ AdventOfCode21.InputHelper.read!("day_4_part_1")) do
    [numbers | boards] = data |> String.split("\n\n", trim: true)

    boards =
      boards
      |> Enum.map(&String.split(&1, "\n", trim: true))
      |> Enum.reduce([], fn board, acc ->
        # Here we expand out the rows and columns so we can iterate through them easily.
        # Is this matrix multiplication??
        rows = board |> Enum.map(&to_ints(&1, " "))
        columns = Enum.zip_with(rows, & &1)
        [rows ++ columns | acc]
      end)

    numbers
    |> to_ints(",")
    |> Enum.reduce_while(boards, fn number, boards ->
      Enum.reduce_while(boards, [], fn board, boards_acc ->
        checked = Enum.map(board, &check_line(&1, number))

        Enum.reduce_while(checked, false, fn
          ["x", "x", "x", "x", "x"], _ -> {:halt, true}
          _, _ -> {:cont, false}
        end)
        |> case do
          # //the board here needs to include the latest markings.
          true -> {:halt, {:win, sum_non_marked_numbers(checked) * number}}
          false -> {:cont, [checked | boards_acc]}
        end
      end)
      |> case do
        {:win, count} -> {:halt, count}
        boards -> {:cont, boards}
      end
    end)
  end

  # This can be a row or a column
  def check_line([number, b, c, d, e], number), do: ["x", b, c, d, e]
  def check_line([a, number, c, d, e], number), do: [a, "x", c, d, e]
  def check_line([a, b, number, d, e], number), do: [a, b, "x", d, e]
  def check_line([a, b, c, number, e], number), do: [a, b, c, "x", e]
  def check_line([a, b, c, d, number], number), do: [a, b, c, d, "x"]
  def check_line(line, _), do: line

  def sum_non_marked_numbers(board) do
    non_marked_rows_and_columns_total =
      Enum.reduce(board, 0, fn line, total ->
        Enum.sum(Enum.reject(line, &(&1 == "x"))) + total
      end)

    # We divide by two because all numbers will be counted twice: once as a row and once as a column
    non_marked_rows_and_columns_total / 2
  end

  def to_ints(input, split_on) do
    input
    |> String.split(split_on, trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def day_4_part_2(data \\ AdventOfCode21.InputHelper.read!("day_4_part_1")) do
  end
end
