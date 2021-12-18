defmodule D5 do

  def part1(input \\ input()) do
    input
    |> parse_input()
    |> Enum.reduce(%{}, fn line, acc ->
      case line do
        [[x1,y1],[x1,y2]] ->
          y1..y2
          |> Enum.reduce(acc, fn y, acc2 ->
            row = Map.get(acc2, y, %{})
            Map.put(acc2, y, Map.put(row, x1, Map.get(row, x1, 0) + 1))
          end)
        [[x1,y1],[x2,y1]] ->
          row = Map.get(acc, y1, %{})
          x1..x2
          |> Enum.reduce(row, fn x, acc -> Map.put(acc, x, Map.get(acc, x, 0) + 1) end)
          |> then(fn new_row -> Map.put(acc, y1, new_row) end)
        _ ->
          acc
      end
    end)
    |> Enum.map(fn {_k, row} ->
      row
      |> Enum.filter(fn {_k, v} -> v >= 2 end)
      |> Enum.count()
    end)
    |> Enum.sum()
  end

  defp input, do: File.read!(__DIR__ <> "/input.txt")

  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.trim()
      |> String.split(" -> ")
      |> Enum.map(fn xy ->
      String.split(xy, ",")
      |> Enum.map(&String.to_integer/1)
      end)
    end)
  end
end
