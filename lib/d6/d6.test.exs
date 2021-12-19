defmodule D6Test do
  use ExUnit.Case

  setup do
    input = "3,4,3,1,2"

     {:ok, %{input: input}}
  end

  test "part1/1 after 18d ays", %{input: input} do
    assert 26 == D6.part1(input, 18)
  end

  test "part1/1 after 80d ays", %{input: input} do
    assert 5934 == D6.part1(input, 80)
  end

  test "part2/1", %{input: input} do
    assert 26 == D6.part2(input, 18)
  end

  test "part2/1 after 80d ays", %{input: input} do
    assert 5934 == D6.part2(input, 80)
  end

  test "part2/1111" do
    assert 8 = D6.part2("3", 24)
  end

  test "get_childern" do
    assert 4 == D6.get_children(18, 3)
  end

  test "get_children for new child" do
    assert 3 == D6.get_children(20)
  end
end
