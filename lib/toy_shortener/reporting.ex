defmodule ToyShortener.Reporting do
  alias ToyShortener.Repo
  require Ecto.Query

  def get_visitor_summary(link) do
    visit_count =
      link
      |> Ecto.assoc(:visits)
      |> Repo.aggregate(:count, :id)

    %{"count" => visit_count}
  end

  @page_size 10
  def get_visits(link, page: page) when is_binary(page) do
    get_visits(link, page: String.to_integer(page))
  end
  def get_visits(link, page: page) when page < 1 do
    get_visits(link, page: 1)
  end
  def get_visits(link, page: page) do
    offset = (page - 1) * @page_size
    link
    |> Ecto.assoc(:visits)
    |> Ecto.Query.order_by([v], v.inserted_at)
    |> Ecto.Query.limit(@page_size)
    |> Ecto.Query.offset(^offset)
    |> Repo.all()
  end
end
