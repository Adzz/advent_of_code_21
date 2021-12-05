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

  @day_2_test_data """
  forward 5
  down 5
  forward 8
  up 3
  down 8
  forward 2
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

  describe "day 2" do
    test "part 1" do
      assert AdventOfCode21.day_2_part_1(@day_2_test_data) == 150
      assert AdventOfCode21.day_2_part_1() == 1561344
    end

    test "part 2" do
    end
  end
end
