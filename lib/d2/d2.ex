defmodule D2 do
  @doc """
    forward X increases the horizontal position by X units.
    down X increases the depth by X units.
    up X decreases the depth by X units.
  """
  def part1(steps \\ input()) do
    coordinates =
      steps
      |> parse_input()
      |> Enum.reduce(%{horizontal: 0, depth: 0}, fn step, acc ->
        case step do
          {"forward", x} -> %{horizontal: acc.horizontal + x, depth: acc.depth}
          {"up", x} -> %{horizontal: acc.horizontal, depth: acc.depth - x}
          {"down", x} -> %{horizontal: acc.horizontal, depth: acc.depth + x}
        end
      end)

    coordinates.depth * coordinates.horizontal
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
