defmodule D3Test do
  use ExUnit.Case

  setup_all do
    input = "00100
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
    01010"
    {:ok, %{input: input}}
  end

  test "part1/1", %{input: input} do
    assert 198 == D3.part1(input)
  end

  test "part2/1", %{input: input} do
    assert 230 == D3.part2(input)
  end
end
