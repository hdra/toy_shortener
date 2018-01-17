defmodule ToyShortenerWeb.LinkController do
  use ToyShortenerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def shorten(conn, %{"new" => params}) do
    ToyShortener.shorten(params["link"])
    |> case do
      {:ok, link} ->
        conn
        |> put_flash(:info, "Link created")
        |> redirect(to: link_path(conn, :display, link.alias))
      {:error, error} ->
        render(conn, "index.html")
    end
  end

  def display(conn, %{"alias" => alias}) do
    ToyShortener.find(alias: alias)
    |> case do
      nil ->
        conn
        |> put_flash(:error, "Link not found")
        |> redirect(to: link_path(conn, :index))
      link ->
        render(conn, "display.html", link: link)
    end
  end
end
