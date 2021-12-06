defmodule D2 do
  @doc """
    forward X increases the horizontal position by X units.
    down X increases the depth by X units.
    up X decreases the depth by X units.
  """
  def part1(steps \\ input()) do
    steps
    |> parse_input()
    |> Enum.reduce(%{horizontal: 0, depth: 0}, fn step, acc ->
      case step do
        {"forward", x} -> %{horizontal: acc.horizontal + x, depth: acc.depth}
        {"up", x} -> %{horizontal: acc.horizontal, depth: acc.depth - x}
        {"down", x} -> %{horizontal: acc.horizontal, depth: acc.depth + x}
      end
    end)
    |> then(fn x -> x.depth * x.horizontal end)
  end

  @doc """
    down X increases your aim by X units.
    up X decreases your aim by X units.
    forward X does two things:
      It increases your horizontal position by X units.
      It increases your depth by your aim multiplied by X
  """
  def part2(steps \\ input()) do
    steps
    |> parse_input()
    |> Enum.reduce(%{horizontal: 0, depth: 0, aim: 0}, fn step, acc ->
      case step do
        {"forward", x} -> %{horizontal: acc.horizontal + x, depth: acc.depth + (acc.aim * x), aim: acc.aim}
        {"up", x} -> %{horizontal: acc.horizontal, depth: acc.depth, aim: acc.aim - x}
        {"down", x} -> %{horizontal: acc.horizontal, depth: acc.depth, aim: acc.aim + x}
      end
    end)
    |> then(fn x -> x.depth * x.horizontal end)
  end

  defp input, do: File.read!(__DIR__ <> "/input.txt")

  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn x ->
      [dir, n] =
        x
        |> String.trim()
        |> String.split(" ")

      {dir, String.to_integer(n)}
    end)
  end
end
