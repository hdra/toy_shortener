defmodule ToyShortener do
  alias ToyShortener.Schemas.Link
  alias ToyShortener.Repo

  def find(opts) do
    Repo.get_by(Link, opts)
  end

  #Get link, return shortened link
  def shorten(link) do
    link_alias = get_alias(link)

    Link.changeset(%Link{}, %{"url" => link, "alias" => link_alias})
    |> Repo.insert()
    |> case do
      {:ok, data} -> {:ok, data}
      {:error, error} -> {:error, error}
    end
  end

  def get_alias(link) do
    #TODO: Replace hashing function
    :crypto.hash(:md5, link)
    |> Base.encode64(padding: false)
  end
end
