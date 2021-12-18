defmodule D5Test do
  use ExUnit.Case

  setup do
    input = "0,9 -> 5,9
    8,0 -> 0,8
    9,4 -> 3,4
    2,2 -> 2,1
    7,0 -> 7,4
    6,4 -> 2,0
    0,9 -> 2,9
    3,4 -> 1,4
    0,0 -> 8,8
    5,5 -> 8,2"

     {:ok, %{input: input}}
  end

  test "part1/1", %{input: input} do
    assert 5 == D5.part1(input)
  end

  # test "part2/1", %{input: input} do
  #   assert 1924 == D4.part2(input)
  # end
end
