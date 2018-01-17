defmodule ToyShortenerWeb.StatsView do
  use ToyShortenerWeb, :view

  def render("summary.json", %{link: link, summary: summary}) do
    %{
      url: link.url,
      alias: link.alias,
      visit_count: summary["count"]
    }
  end

  def render("error.json", %{message: message}) do
    %{errors: message}
  end

  def render("visits.json", %{visits: visits}) do
    %{
      data: render_many(visits, ToyShortenerWeb.StatsView, "visit.json", as: :visit)
    }
  end

  def render("visit.json", %{visit: visit}) do
    %{
      ip_address: visit.ip_address,
      user_agent: visit.user_agent,
      referal: visit.referal,
      timestamp: visit.inserted_at
    }
  end
end
