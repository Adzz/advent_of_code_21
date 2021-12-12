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

  @day_4_test_data """
  7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

  22 13 17 11  0
   8  2 23  4 24
  21  9 14 16  7
   6 10  3 18  5
   1 12 20 15 19

   3 15  0  2 22
   9 18 13 17  5
  19  8  7 25 23
  20 11 10 24  4
  14 21 16 12  6

  14 21 17 24  4
  10 16 15  9 19
  18  8 23 26 20
  22 11 13  6  5
   2  0 12  3  7
  """

  @day_5_test_data """
  0,9 -> 5,9
  8,0 -> 0,8
  9,4 -> 3,4
  2,2 -> 2,1
  7,0 -> 7,4
  6,4 -> 2,0
  0,9 -> 2,9
  3,4 -> 1,4
  0,0 -> 8,8
  5,5 -> 8,2
  """

  describe "day 1" do
    test "part 1" do
      assert AdventOfCode21.Day1.day_1_part_1() == 1226
      assert AdventOfCode21.Day1.day_1_part_1(@day_1_test_data) == 7
    end

    test "part 2" do
      assert AdventOfCode21.Day1.day_1_part_2(@day_1_test_data) == 5
      assert AdventOfCode21.Day1.day_1_part_2() == 1252
    end
  end

  describe "day 2" do
    test "part 1" do
      assert AdventOfCode21.Day2.day_2_part_1(@day_2_test_data) == 150
      assert AdventOfCode21.Day2.day_2_part_1() == 1_561_344
    end

    test "part 2" do
      assert AdventOfCode21.Day2.day_2_part_2(@day_2_test_data) == 900
      assert AdventOfCode21.Day2.day_2_part_2() == 1_848_454_425
    end
  end

  describe "day 3" do
    test "part 1" do
      assert AdventOfCode21.Day3.day_3_part_1(@day_3_test_data) == 198
      assert AdventOfCode21.Day3.day_3_part_1() == 2_250_414
    end

    test "part 2" do
      assert AdventOfCode21.Day3.day_3_part_2(@day_3_test_data) == 230
      assert AdventOfCode21.Day3.day_3_part_2() == 6_085_575
    end
  end

  describe "day 4" do
    test "part 1" do
      assert AdventOfCode21.Day4.day_4_part_1(@day_4_test_data) == 4512
      assert AdventOfCode21.Day4.day_4_part_1() == 35670
    end

    test "part 2" do
      assert AdventOfCode21.Day4.day_4_part_2(@day_4_test_data) == 1924
      assert AdventOfCode21.Day4.day_4_part_2() == 22704
    end
  end

  describe "day 5" do
    test "part 1" do
      assert AdventOfCode21.Day5.day_5_part_1(@day_5_test_data) == 5
      assert AdventOfCode21.Day5.day_5_part_1() == 4745
    end

    test "part 2" do
      # assert AdventOfCode21.Day5.day_5_part_2(@day_5_test_data) == 1924
      # assert AdventOfCode21.Day5.day_5_part_2() == 22704
    end
  end
end
