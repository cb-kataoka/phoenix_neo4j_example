defmodule Mix.Tasks.ImportSeedData do
  use Mix.Task

  alias Bolt.Sips, as: Neo
  alias Bolt.Sips.Response
  alias PhoenixNeo4jExample.Node
  alias PhoenixNeo4jExample.Route

  @shortdoc "Create nodes and links."
  def run(_) do
    :ok = start_dependencies()
    create_nodes_and_relationships()
    IO.puts "Finished."
  end

  defp start_dependencies, do: Mix.Task.run("app.start")

  defp create_nodes_and_relationships do
    query = Node.cyper_query(:create) <> "\n" <> Route.cyper_query(:create)
    %Response{stats: result} = Neo.conn() |> Neo.query!(query)
    IO.inspect result
  end
end
