defmodule AdventOfCode21Test do
  use ExUnit.Case

  @day_1_test_data """
  199
  200
  208
  210
  200
  207
  240
  269
  260
  263
  """

  describe "day 1" do
    test "part 1" do
      assert AdventOfCode21.day_1_part_1() == 1226
      assert AdventOfCode21.day_1_part_1(@day_1_test_data) == 7
    end

    test "part 2" do
      assert AdventOfCode21.day_1_part_2(@day_1_test_data) == 5
      assert AdventOfCode21.day_1_part_2() == 1252
    end
  end
end
