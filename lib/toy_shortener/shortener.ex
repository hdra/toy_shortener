defmodule ToyShortener.Shortener do
  @strategies [
    hash: ToyShortener.Strategies.Hash,
    random: ToyShortener.Strategies.Random,
    encode: ToyShortener.Strategies.Encode,
  ]

  def shorten(link, tries, strategy \\ :random) do
    shortener = Keyword.get(@strategies, strategy)
    shortener.shorten(link, tries)
  end
end
