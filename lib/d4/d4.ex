defmodule D4 do

  def part1(bingo \\ input()) do
    {nums, boards} =
      bingo
      |> parse_input()
    nums
    # If num exists in the board replace it with nil
    |> Enum.reduce_while(boards, fn n, acc ->
      boards =
        acc
        |> Enum.map(fn board ->
          board
          |> Enum.map(fn row_or_column ->
            row_or_column
            |> Enum.map(fn num ->
                if num == n do
                  nil
                else
                  num
                end
              end)
          end)
        end)
        # Check if whole row or column are nils, if so break the loop, we've got the winner
        boards
        |> Enum.filter(fn board ->
          columns = for i <- 0..4, do: Enum.map(board, fn row -> Enum.at(row, i) end)
          Enum.any?(board ++ columns, fn row -> Enum.all?(row, fn x -> x == nil end) end)
        end)
        |> case do
          [] ->
            {:cont, boards}
          board ->
            {:halt, {n, board}}
        end
    end)
    |> then(fn {num, board} ->
      # Multiply winning num and sum of the winning board
      board
      |> List.flatten
      |> Enum.filter(fn x -> x != nil end)
      |> Enum.sum()
      |> Kernel.*(num)
    end)
  end


  def part2(bingo \\ input()) do
    {nums, boards} =
      bingo
      |> parse_input()
    nums
    # If num exists in the board replace it with nil
    |> Enum.reduce_while(boards, fn n, acc ->
      boards =
        acc
        |> Enum.map(fn board ->
          board
          |> Enum.map(fn row_or_column ->
            row_or_column
            |> Enum.map(fn num ->
                if num == n do
                  nil
                else
                  num
                end
              end)
          end)
        end)
        # Check if whole row or column are nils, if so remove this board from pool, continue with other boards
        boards
        |> Enum.filter(fn board ->
          columns = for i <- 0..4, do: Enum.map(board, fn row -> Enum.at(row, i) end)
          Enum.any?(board ++ columns, fn row -> Enum.all?(row, fn x -> x == nil end) end)
        end)
        |> case do
          [] ->
            {:cont, boards}
          winning_boards ->
            case length(boards) do
              1 ->
                {:halt, {n, winning_boards}}
              _ ->
                boards_left = Enum.filter(boards, fn x -> !(x in winning_boards) end)
                {:cont, boards_left}
            end
        end
    end)
    |> then(fn {num, board} ->
      # Multiply winning num and sum of the winning board
      board
      |> List.flatten
      |> Enum.filter(fn x -> x != nil end)
      |> Enum.sum()
      |> Kernel.*(num)
    end)
  end

  defp input, do: File.read!(__DIR__ <> "/input.txt")

  defp parse_input(input) do
    input
    |> String.split("\n\n")
    |> then(fn [nums | boards] ->
      nums = String.split(nums, ",") |> Enum.map(&String.to_integer/1)
      boards =
        boards
        |> Enum.map(fn board ->
          board
          |> String.split("\n", trim: true)
          |> Enum.map(fn row ->
            row
            |> String.trim()
            |> String.replace("  ", " ")
            |> String.split(" ")
            |> Enum.map(&String.to_integer/1)
          end)
        end)
      {nums, boards}
    end)
  end
end
