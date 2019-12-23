defmodule PhoenixNeo4jExampleWeb.NodeController do
  use PhoenixNeo4jExampleWeb, :controller

  alias PhoenixNeo4jExample.Node

  def index(conn, _params) do
    with {:ok, nodes} <- Node.list do
      render(conn, "index.json", nodes: nodes)
    end
  end
end
