defmodule Day2Solver do
  def is_save_lesser(_list, count) when count > 1 do
    false
  end

  def is_save_lesser(list, count) do
    case list do
      [] ->
        true

      [_] ->
        true

      [a, b | tail] when (a - b) in 1..3 ->
        is_save_lesser([b | tail], count)

      [a, b | tail] when (a - b) not in 1..3 ->
        is_save_lesser([a | tail], count + 1)

      _ ->
        false
    end
  end

  def is_save_greater(_list, count) when count > 1 do
    false
  end

  def is_save_greater(list, count) do
    case list do
      [] ->
        true

      [_] ->
        true

      [a, b | tail] when (b - a) in 1..3 ->
        is_save_greater([b | tail], count)

      [a, b | tail] when (b - a) not in 1..3 ->
        is_save_greater([a | tail], count + 1)

      _ ->
        false
    end
  end

  def is_save(list) do
    case list do
      [a, b | tail] ->
        is_save_lesser([a, b | tail], 0) or is_save_lesser([b | tail], 1) or
          is_save_greater([a, b | tail], 0) or is_save_greater([b | tail], 1)

      [] ->
        true

      [_] ->
        true

      _ ->
        false
    end
  end
end

list =
  File.stream!("./day2.input", :line)
  |> Stream.map(&String.trim/1)
  |> Stream.filter(&(byte_size(&1) > 0))
  |> Stream.map(&String.split(&1, " "))
  |> Stream.map(fn list -> Enum.map(list, &String.to_integer/1) end)
  |> Stream.filter(&Day2Solver.is_save(&1))
  |> Enum.to_list()

IO.inspect(list, charlists: :as_lists, label: "data")
IO.inspect(Kernel.length(list), label: "safe")
