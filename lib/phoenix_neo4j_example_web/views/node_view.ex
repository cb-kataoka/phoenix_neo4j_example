defmodule PhoenixNeo4jExampleWeb.NodeView do
  use PhoenixNeo4jExampleWeb, :view

  def render("index.json", %{nodes: nodes}) do
    data =
      nodes
      |> Enum.map(fn(node) ->
        %{id: node[:id], name: node[:name], location: node[:location]}
      end)
    %{data: data}
  end
end
