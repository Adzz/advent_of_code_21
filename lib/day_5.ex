defmodule AdventOfCode21.Day5 do
  @doc """
  Right so we get a bunch of co-ords that we need to mark. The issue is we don't know how
  large the board is.

  Right so after a lot of faff the insight is that of course what we are trying to do is
  just count the frequencies of each of the cells. That means we just need to expand each
  of the coords to capture each cell they cross, then merge all cells into a map. Anytime
  the cell already exists in the map you just increase the count.

  So imagine cell `{0, 0}` the first time we see it we'd do this:
      %{ {0,0} => 1 }

  Then the next time we would do: `%{ {0, 0} => 2 }`
  """
  def day_5_part_1(data \\ AdventOfCode21.InputHelper.read!("day_5")) do
    data
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{}, fn coords, cells ->
      coords
      |> String.split(" -> ", trim: true)
      |> Enum.map(fn xy ->
        String.split(xy, ",", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)
      |> expand_non_diagonal()
      |> case do
        :diagonal -> cells
        line_cells -> Map.merge(cells, line_cells, fn _k, v1, _v2 -> v1 + 1 end)
      end
    end)
    |> Enum.reduce(0, fn {_key, v}, count -> if v >= 2, do: count + 1, else: count end)
  end

  def expand_non_diagonal([[x1, y], [x2, y]]) do
    min(x1, x2)..max(x1, x2)
    |> Enum.reduce(%{}, fn x, acc ->
      Map.put(acc, {x, y}, 1)
    end)
  end

  def expand_non_diagonal([[x, y1], [x, y2]]) do
    min(y1, y2)..max(y1, y2)
    |> Enum.reduce(%{}, fn y, acc ->
      Map.put(acc, {x, y}, 1)
    end)
  end

  def expand_non_diagonal(_), do: :diagonal

  def day_5_part_2(data \\ AdventOfCode21.InputHelper.read!("day_5")) do
    data
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{}, fn coords, cells ->
      coords
      |> String.split(" -> ", trim: true)
      |> Enum.map(fn xy ->
        String.split(xy, ",", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)
      |> expand_line()
      |> case do
        :diagonal -> cells
        line_cells -> Map.merge(cells, line_cells, fn _k, v1, _v2 -> v1 + 1 end)
      end
    end)
    |> Enum.reduce(0, fn {_key, v}, count -> if v >= 2, do: count + 1, else: count end)
  end

  def expand_line([[x1, y], [x2, y]]) do
    min(x1, x2)..max(x1, x2)
    |> Enum.reduce(%{}, fn x, acc ->
      Map.put(acc, {x, y}, 1)
    end)
  end

  def expand_line([[x, y1], [x, y2]]) do
    min(y1, y2)..max(y1, y2)
    |> Enum.reduce(%{}, fn y, acc ->
      Map.put(acc, {x, y}, 1)
    end)
  end

  def expand_line([[x1, y1], [x2, y2]]) do
    steps = max(y1, y2) - min(y1, y2)

    case {x1 < x2, y1 < y2} do
      # RIGHT UP
      {true, true} ->
        0..steps
        |> Enum.reduce(%{}, fn step, acc ->
          Map.put(acc, {x1 + step, y1 + step}, 1)
        end)

      # LEFT UP
      {false, true} ->
        0..steps
        |> Enum.reduce(%{}, fn step, acc ->
          Map.put(acc, {x1 - step, y1 + step}, 1)
        end)

      # RIGHT DOWN
      {true, false} ->
        0..steps
        |> Enum.reduce(%{}, fn step, acc ->
          Map.put(acc, {x1 + step, y1 - step}, 1)
        end)

      # LEFT DOWN
      {false, false} ->
        0..steps
        |> Enum.reduce(%{}, fn step, acc ->
          Map.put(acc, {x1 - step, y1 - step}, 1)
        end)
    end
  end
end
