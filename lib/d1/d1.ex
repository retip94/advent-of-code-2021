defmodule D1 do
  @moduledoc """
    https://adventofcode.com/2021/day/1
  """

  def part1(depths \\ input()) do
    depths
    |> parse_input()
    |> Enum.reduce(%{last: nil, count: 0}, fn d, acc ->
      case d > acc.last do
        true -> %{last: d, count: acc.count + 1}
        false -> %{last: d, count: acc.count}
      end
    end)
    |> Map.get(:count)
  end

  def part2(depths \\ input()) do
    depths = parse_input(depths)

    Enum.reduce(depths, %{i: 0, last_sum: nil, count: 0}, fn _d, acc ->
      window = Enum.slice(depths, acc.i, 3)

      if length(window) != 3 do
        acc
      else
        sum = Enum.sum(window)

        case sum > acc.last_sum do
          true -> %{i: acc.i + 1, last_sum: sum, count: acc.count + 1}
          false -> %{i: acc.i + 1, last_sum: sum, count: acc.count}
        end
      end
    end)
    |> Map.get(:count)
  end

  defp input, do: File.read!(__DIR__ <> "/input.txt")

  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn a ->
      a
      |> String.trim()
      |> String.to_integer()
    end)
  end
end
