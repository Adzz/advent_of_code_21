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

  @day_3_test_data """
  00100
  11110
  10110
  10111
  10101
  01111
  00111
  11100
  10000
  11001
  00010
  01010
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
      assert AdventOfCode21.day_2_part_1() == 1_561_344
    end

    test "part 2" do
      assert AdventOfCode21.day_2_part_2(@day_2_test_data) == 900
      assert AdventOfCode21.day_2_part_2() == 1_848_454_425
    end
  end

  describe "day 3" do
    test "part 1" do
      assert AdventOfCode21.day_3_part_1(@day_3_test_data) == 198
      assert AdventOfCode21.day_3_part_1() == 2_250_414
    end

    test "part 2" do
      assert AdventOfCode21.day_3_part_2(@day_3_test_data) == 230
      assert AdventOfCode21.day_3_part_2() == 6085575
    end
  end
end
