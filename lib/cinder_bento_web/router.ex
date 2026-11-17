defmodule CinderBentoWeb.Router do
  use CinderBentoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {CinderBentoWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CinderBentoWeb do
    pipe_through :browser

    live "/", AlbumLive.Index
  end

  # Other scopes may use custom stacks.
  # scope "/api", CinderBentoWeb do
  #   pipe_through :api
  # end
end
