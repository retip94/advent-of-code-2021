defmodule D7Test do
  use ExUnit.Case

  setup_all do
    input = "16,1,2,0,4,2,7,1,2,14"
    {:ok, %{input: input}}
  end

  test "part1/1", %{input: input} do
    assert 37 == D7.part1(input)
  end

  test "part2/1", %{input: input} do
    assert 168 == D7.part2(input)
  end
end
