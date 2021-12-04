defmodule AdventOfCode21.InputHelper do
  def read!(file), do: File.read!(Path.expand("./lib/inputs/" <> file <> ".txt"))
end
