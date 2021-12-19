defmodule D6 do

  def part1(input \\ input(), days \\ 80) do
    start_fish = parse_input(input)
    1..days
    |> Enum.reduce(start_fish, fn _d, fish ->
      fish
      |> reset_and_create_fish()
      |> Enum.map(fn f -> f - 1 end)
    end)
    |> Enum.count()
  end

  defp reset_and_create_fish(fish) do
    fish
    |> Enum.reduce(fish, fn f, acc ->
      case f do
        0 ->
          acc ++ [9]
        _ ->
          acc
      end
    end)
    |> Enum.map(fn f -> if f == 0 do 7 else f end end)
  end

  def part2(input \\ input(), days \\ 256) do
    start_fish = parse_input(input)
    i = 1
    Enum.count(start_fish) + Enum.sum(Enum.map(start_fish, fn f ->
      i = i + 1
      IO.inspect("#{i} of #{length(start_fish)}")
      get_children(days, f)
    end))
  end


  def get_children(days_left, next_child \\ 9)

  def get_children(days_left, next_child) when next_child >= days_left do
    0
  end

  def get_children(days_left, next_child) when days_left - next_child <= 7 do
    1
  end

  def get_children(days_left, next_child) do
    first_child = days_left - next_child
    children =
      Enum.reduce(1..div(first_child - 1, 7), [first_child], fn i, acc ->
        acc ++ [first_child - (i * 7)]
      end)
    Enum.count(children) + Enum.sum(Enum.map(children, fn c -> get_children(c) end))
  end

  defp input, do: File.read!(__DIR__ <> "/input.txt")

  defp parse_input(input) do
    input
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end
end
