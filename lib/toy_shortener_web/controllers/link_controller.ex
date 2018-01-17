defmodule ToyShortenerWeb.LinkController do
  use ToyShortenerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def shorten(conn, %{"new" => params}) do
    ToyShortener.shorten(params["link"])
    |> case do
      {:exists, link} ->
        conn
        |> put_flash(:info, "Short link already exists")
        |> redirect(to: link_path(conn, :display, link.alias))
      {:ok, link} ->
        conn
        |> put_flash(:info, "Short link created")
        |> redirect(to: link_path(conn, :display, link.alias))
      {:error, _error} ->
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

  def resolve(conn,  %{"alias" => alias}) do
    ToyShortener.find(alias: alias)
    |> case do
      nil ->
        conn
        |> put_flash(:error, "The link you're trying to reach doesn't exist.")
        |> redirect(to: link_path(conn, :index))
      link ->
        ToyShortener.record_visit(link, extract_visitor_info(conn))
        redirect(conn, external: link.url)
    end
  end

  defp extract_visitor_info(conn) do
    ip =
      conn.remote_ip
      |> Tuple.to_list()
      |> Enum.join(".")
    %{
      "ip_address" => ip,
      "user_agent" => get_req_header(conn, "user-agent") |> List.first(),
      "referal" => get_req_header(conn, "referer") |> List.first(),
    }
  end
end
