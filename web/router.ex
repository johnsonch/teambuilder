defmodule Teambuilder.Router do
  use Teambuilder.Web, :router

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

  scope "/", Teambuilder do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/teams", TeamController do
      resources "/sheets", SheetController
    end
    resources "/sheets", SheetController, except: [:index]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Teambuilder do
  #   pipe_through :api
  # end
end
