defmodule ToyShortener.Strategies.Encode do
  #https://stackoverflow.com/questions/742013/how-to-code-a-url-shortener

  @charsets "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-_"
  @base String.length(@charsets)

  def shorten(link, _tries) do
    encode(link.id)
  end

  def encode(num) when is_integer(num) do
    encode("", num)
  end
  defp encode(acc, num) when num < 1, do: acc
  defp encode(acc, num) do
    encode(
      String.at(@charsets, rem(num, @base)) <> acc,
      div(num, @base)
    )
  end

  def decode(str) when is_bitstring(str) do
    decode(str, 0, 0)
  end
  defp decode(str, num, index) do
    if index < String.length(str) do
      {char_index, 1} = :binary.match(@charsets, String.at(str, index))
      decode(str, num * @base + char_index, index + 1)
    else
      num
    end
  end
end
