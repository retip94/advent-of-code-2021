defmodule D1Test do
  use ExUnit.Case

  setup_all do
    ocean_depths = "199
      200
      208
      210
      200
      207
      240
      269
      260
      263"
    {:ok, %{ocean_depths: ocean_depths}}
  end

  test "part1/1", %{ocean_depths: ocean_depths} do
    assert 7 == D1.part1(ocean_depths)
  end

  test "part2/1", %{ocean_depths: ocean_depths} do
    assert 5 == D1.part2(ocean_depths)
  end
end
