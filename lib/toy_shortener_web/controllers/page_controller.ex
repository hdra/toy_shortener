defmodule ToyShortenerWeb.PageController do
  use ToyShortenerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
