defmodule D2Test do
  use ExUnit.Case

  setup_all do
    input = "forward 5
    down 5
    forward 8
    up 3
    down 8
    forward 2"
    {:ok, %{input: input}}
  end

  test "part1/1", %{input: input} do
    assert 150 == D2.part1(input)
  end
end
