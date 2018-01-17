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
end
