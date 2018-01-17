defmodule ToyShortenerWeb.StatsController do
  use ToyShortenerWeb, :controller

  def summary(conn, %{"alias" => alias}) do
    ToyShortener.find(alias: alias)
    |> case do
      nil ->
        conn
        |> put_status(:not_found)
        |> render("error.json", message: "Link not found")
      link ->
        summary = ToyShortener.Reporting.get_visitor_summary(link)
        conn
        |> render("summary.json", link: link, summary: summary)
    end
  end

  def visits(conn, %{"alias" => alias} = params) do
    ToyShortener.find(alias: alias)
    |> case do
      nil ->
        conn
        |> put_status(:not_found)
        |> render("error.json", message: "Link not found")
      link ->
        visits = ToyShortener.Reporting.get_visits(link, page: params["page"] || 1)
        conn
        |> render("visits.json", visits: visits)
    end
  end
end
