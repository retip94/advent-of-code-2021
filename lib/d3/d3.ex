defmodule D3 do

  def part1(report \\ input()) do
    report =
      report
      |> parse_input()
    limit = String.length(List.first(report)) - 1
    rates =
      Enum.reduce(0..limit, %{gamma: "", epsilon: ""}, fn i, acc ->
        bits_count =
          Enum.map(report, fn x -> String.at(x, i) end)
          |> Enum.reduce(%{count0: 0, count1: 0}, fn bits, acc ->
            case bits do
              "0" -> %{count0: acc.count0 + 1, count1: acc.count1}
              "1" -> %{count0: acc.count0, count1: acc.count1 + 1}
            end
          end)
        case bits_count.count0 > bits_count.count1 do
          true -> %{gamma: acc.gamma <> "0", epsilon: acc.epsilon <> "1"}
          false -> %{gamma: acc.gamma <> "1", epsilon: acc.epsilon <> "0"}
        end
      end)
      String.to_integer(rates.gamma, 2) * String.to_integer(rates.epsilon, 2)
  end

  def part2(report \\ input()) do
    report =
      report
      |> parse_input()
    limit = String.length(List.first(report)) - 1
    Enum.reduce_while(0..limit, %{values: report}, fn i, acc ->

    end)
  end

  defp input, do: File.read!(__DIR__ <> "/input.txt")

  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn x ->
        x
        |> String.trim()
    end)
  end
end
