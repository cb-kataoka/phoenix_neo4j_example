defmodule PhoenixNeo4jExampleWeb.Route.SearchController do
  use PhoenixNeo4jExampleWeb, :controller

  alias PhoenixNeo4jExample.Route

  def index(conn, %{"from" => from, "to" => to, "limit" => limit}) do
    with {:ok, routes} <- Route.search(from, to, limit) do
      render(conn, "index.json", routes: routes)
    end
  end
end
