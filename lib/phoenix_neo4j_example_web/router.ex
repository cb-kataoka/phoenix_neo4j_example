defmodule PhoenixNeo4jExampleWeb.Router do
  use PhoenixNeo4jExampleWeb, :router

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

  scope "/", PhoenixNeo4jExampleWeb do
    pipe_through :api

    get "/healthcheck", HealthcheckController, :show
    resources "/nodes", NodeController, only: [:index]
    get "/routes/search", Route.SearchController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixNeo4jExampleWeb do
  #   pipe_through :api
  # end
end
