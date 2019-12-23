defmodule PhoenixNeo4jExampleWeb.HealthcheckController do
  use PhoenixNeo4jExampleWeb, :controller

  def show(conn, _params) do
    text conn, "ok"
  end
end
