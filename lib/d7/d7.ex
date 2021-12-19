defmodule D7 do

  def part1(positions \\ input()) do
    positions = parse_input(positions)
    last_position = Enum.max(positions)
    fuel_for_last = get_needed_fuel(positions, last_position)
    0..last_position
    |> Enum.reduce_while(fuel_for_last, fn meeting, acc ->
      needed_fuel = get_needed_fuel(positions, meeting)
      case needed_fuel < acc do
         true ->
          {:cont, needed_fuel}
        false ->
          {:halt, acc}
      end
    end)
  end

  defp get_needed_fuel(positions, meeting) do
    Enum.map(positions, fn x ->
      abs(meeting - x)
    end)
    |> Enum.sum()
  end

  def part2(positions \\ input()) do
    positions = parse_input(positions)
    last_position = Enum.max(positions)
    fuel_for_last = get_needed_fuel_p2(positions, last_position)
    0..last_position
    |> Enum.reduce_while(fuel_for_last, fn meeting, acc ->
      needed_fuel = get_needed_fuel_p2(positions, meeting)
      case needed_fuel < acc do
         true ->
          {:cont, needed_fuel}
        false ->
          {:halt, acc}
      end
    end)
    |> trunc()
  end

  defp get_needed_fuel_p2(positions, meeting) do
    Enum.map(positions, fn x ->
      dist = abs(meeting - x)
      (dist * (dist + 1)) / 2
    end)
    |> Enum.sum()
  end

  defp input, do: File.read!(__DIR__ <> "/input.txt")

  defp parse_input(input) do
    input
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end
end
