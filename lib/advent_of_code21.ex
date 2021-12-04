defmodule AdventOfCode21 do
  @moduledoc """
  """

  @doc """
  See README, essentially recur through the list and see how many times the measurement
  is more than its previous measurement.
  """
  def day_1 do
    AdventOfCode21.InputHelper.read!("day_1")
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&elem(Integer.parse(&1), 0))
    |> scan_measurements(0)
  end

  defp scan_measurements([], count), do: count
  defp scan_measurements([_prev], count), do: count

  defp scan_measurements([prev, next | rest], count) do
    new_count = if prev < next, do: count + 1, else: count
    scan_measurements([next | rest], new_count)
  end
end
