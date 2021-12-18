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
            Map.put(acc2, y, incr_val_in_map(row, x1))
          end)
        [[x1,y1],[x2,y1]] ->
          row = Map.get(acc, y1, %{})
          x1..x2
          |> Enum.reduce(row, fn x, acc2 -> incr_val_in_map(acc2, x) end)
          |> then(fn new_row -> Map.put(acc, y1, new_row) end)
        _ ->
          acc
      end
    end)
    |> sum_interesctions()
  end

  def part2(input \\ input()) do
    input
    |> parse_input()
    |> Enum.reduce(%{}, fn line, acc ->
      case line do
        [[x1,y1],[x1,y2]] ->
          y1..y2
          |> Enum.reduce(acc, fn y, acc2 ->
            row = Map.get(acc2, y, %{})
            Map.put(acc2, y, incr_val_in_map(row, x1))
          end)
        [[x1,y1],[x2,y1]] ->
          row = Map.get(acc, y1, %{})
          x1..x2
          |> Enum.reduce(row, fn x, acc2 -> incr_val_in_map(acc2, x) end)
          |> then(fn new_row -> Map.put(acc, y1, new_row) end)
        [[x1,y1],[x2,y2]] ->
          Enum.zip(x1..x2, y1..y2)
          |> Enum.reduce(acc, fn {x, y}, acc2 ->
            row = Map.get(acc2, y, %{})
            Map.put(acc2, y, incr_val_in_map(row, x))
          end)
      end
    end)
    |> sum_interesctions()
  end


  defp sum_interesctions(coords_map) do
    coords_map
    |> Enum.map(fn {_k, row} ->
      row
      |> Enum.filter(fn {_k, v} -> v >= 2 end)
      |> Enum.count()
    end)
    |> Enum.sum()
  end

  defp incr_val_in_map(map, key) do
    new_value = Map.get(map, key, 0) + 1
    Map.put(map, key, new_value)
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
