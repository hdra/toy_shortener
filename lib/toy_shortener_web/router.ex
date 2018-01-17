defmodule ToyShortenerWeb.Router do
  use ToyShortenerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ToyShortenerWeb do
    pipe_through :browser # Use the default browser stack

    get "/", LinkController, :index
    post "/", LinkController, :shorten
    get "/:alias/view", LinkController, :display
    get "/:alias", LinkController, :resolve
  end

  # Other scopes may use custom stacks.
  # scope "/api", ToyShortenerWeb do
  #   pipe_through :api
  # end
end
