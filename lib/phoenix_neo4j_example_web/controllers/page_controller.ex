defmodule PhoenixNeo4jExampleWeb.PageController do
  use PhoenixNeo4jExampleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
