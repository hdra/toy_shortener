defmodule ToyShortener.Reporting do
  alias ToyShortener.Repo

  def get_visitor_summary(link) do
    visit_count =
      link
      |> Ecto.assoc(:visits)
      |> Repo.aggregate(:count, :id)

    %{"count" => visit_count}
  end
end
