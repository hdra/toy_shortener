defmodule ToyShortener do
  alias ToyShortener.Schemas.{Link, Visit}
  alias ToyShortener.Repo
  alias Sqlite.DbConnection.Error, as: SqliteError

  def find(opts) do
    Repo.get_by(Link, opts)
  end

  #Get link, return shortened link
  def shorten(link) do
    find(url: link)
    |> case do
      nil -> create_link(link)
      data -> {:exists, data}
    end
  end

  def create_link(link, tries \\ 0)
  def create_link(link, tries) when tries < 10 do
    try do
      link_alias = get_alias(link)

      Link.changeset(%Link{}, %{"url" => link, "alias" => link_alias})
      |> Repo.insert()
      |> case do
        {:ok, data} -> {:ok, data}
        {:error, error} -> {:error, error}
      end
    rescue
      SqliteError -> create_link(link, tries + 1)
      e -> {:error, e.message}
    end
  end

  def create_link(_link, 10) do
    {:error, "Unable to generate shortlink"}
  end

  def get_alias(link) do
    #TODO: Replace hashing function
    :crypto.hash(:md5, link)
    |> Base.encode64(padding: false)
  end

  def record_visit(link, info) do
    ToyShortener.Logger.record_visit(link, info)
  end
  def record_visit(link, info, :sync) do
    Ecto.build_assoc(link, :visits)
    |> Visit.changeset(info)
    |> Repo.insert!()
  end
end
