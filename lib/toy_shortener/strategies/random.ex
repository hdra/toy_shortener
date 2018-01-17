defmodule ToyShortener.Strategies.Random do
  @length 8
  def shorten(_link, _tries) do
    randomise(@length)
  end

  @charsets "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" |> String.split("", split: true)
  defp randomise(length) do
    Enum.reduce((1..length), [], fn (_i, acc) ->
      [Enum.random(@charsets) | acc]
    end)
    |> Enum.join("")
  end
end
