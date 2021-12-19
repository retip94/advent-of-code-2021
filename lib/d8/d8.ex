defmodule D8 do

  def part1(input \\ input()) do
    lines = parse_input(input)
    lines
    |> Enum.map(fn [_test, output] ->
      Enum.count(output, fn x -> length(x) in [2, 3, 4, 7] end)
    end)
    |> Enum.sum()
  end

  def part2(input \\ input()) do
      parse_input(input)
      |> Enum.map(fn [to_learn, output] ->
        to_learn = Enum.sort(to_learn, &(length(&1) < length(&2)))
        {learnt, rest} = get_number(1, to_learn)
        {learnt, _rest} =
          [7,4,8,9,2,5,3,6,0]
          |> Enum.reduce({learnt, rest}, fn num, {learnt, rest} ->
            get_number(num, rest, learnt)
          end)
        decode_output(learnt, output)
        |> Integer.undigits()
      end)
      |> Enum.sum()
  end

  defp decode_output(learnt, output) do
    output
    |> Enum.map(fn code ->
      {num, _v} =
        Enum.find(learnt, nil, fn {_k, v} ->
          length(v) == length(code) && (code -- v) == []
        end)
      num
    end)
  end

  defp get_number(num, to_learn, learnt \\ %{})

  defp get_number(num, to_learn, learnt) when num in [1,7,4] do
    [code | rest] = to_learn
    {Map.put(learnt, num, code), rest}
  end

  defp get_number(8 = num, to_learn, learnt) do
    {rest, [code]} = Enum.split(to_learn, 6)
    {Map.put(learnt, num, code), rest}
  end

  defp get_number(9 = num, to_learn, learnt) do
    must_contain = Enum.uniq(learnt[4] ++ learnt[7])
    code = Enum.find(to_learn, nil, fn c -> must_contain -- c == [] end)
    rest = to_learn -- [code]
    {Map.put(learnt, num, code), rest}
  end

  defp get_number(2 = num, to_learn, learnt) do
    must_contain = learnt[8] -- learnt[9]
    code = Enum.find(to_learn, nil, fn c -> length(c) == 5 && must_contain -- c == [] end)
    rest = to_learn -- [code]
    {Map.put(learnt, num, code), rest}
  end

  defp get_number(5 = num, to_learn, learnt) do
    must_contain = learnt[9] -- learnt[7]
    code = Enum.find(to_learn, nil, fn c -> length(c) == 5 && must_contain -- c == [] end)
    rest = to_learn -- [code]
    {Map.put(learnt, num, code), rest}
  end

  defp get_number(3 = num, to_learn, learnt) do
    code = Enum.find(to_learn, nil, fn c -> length(c) == 5 end)
    rest = to_learn -- [code]
    {Map.put(learnt, num, code), rest}
  end

  defp get_number(6 = num, to_learn, learnt) do
    must_contain = learnt[8] -- learnt[7]
    code = Enum.find(to_learn, nil, fn c -> length(c) == 6 && must_contain -- c == [] end)
    rest = to_learn -- [code]
    {Map.put(learnt, num, code), rest}
  end

  defp get_number(0 = num, to_learn, learnt) do
    code = Enum.find(to_learn, nil, fn c -> length(c) == 6 end)
    rest = to_learn -- [code]
    {Map.put(learnt, num, code), rest}
  end

  defp input, do: File.read!(__DIR__ <> "/input.txt")

  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      String.trim(line)
      |> String.split(" | ")
      |> Enum.map(fn digits ->
        String.split(digits, " ")
        |> Enum.map(&String.graphemes/1)
      end)
    end)
  end
end
