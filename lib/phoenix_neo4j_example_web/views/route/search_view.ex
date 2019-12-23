defmodule PhoenixNeo4jExampleWeb.Route.SearchView do
  use PhoenixNeo4jExampleWeb, :view

  def render("index.json", %{routes: routes}) do
    %{data: routes}
  end
end
