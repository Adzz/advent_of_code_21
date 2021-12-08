defmodule AdventOfCode21.InputHelper do
  def read!(file), do: File.read!(Path.expand("./lib/inputs/" <> file <> ".txt"))

  def to_list(string) do
    string
    |> String.trim()
    |> String.split("\n")
  end
end
