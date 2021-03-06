defmodule ToyShortener.Strategies.Hash do
  def shorten(link, tries) do
    :crypto.hash(:md5, "#{link.url}#{tries}")
    |> Base.encode64(padding: false)
  end
end
