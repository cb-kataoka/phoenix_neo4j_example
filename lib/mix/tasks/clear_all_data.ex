defmodule Mix.Tasks.ClearAllData do
  use Mix.Task

  alias Bolt.Sips, as: Neo
  alias Bolt.Sips.Response

  @query ~s"""
  MATCH (n)
  DETACH DELETE n
  """

  @shortdoc "Create nodes and links."
  def run(_) do
    :ok = start_dependencies()
    exec_query()
    IO.puts "Finished."
  end

  defp start_dependencies, do: Mix.Task.run("app.start")

  defp exec_query do
    %Response{stats: result} = Neo.conn() |> Neo.query!(@query)
    IO.inspect result
  end
end
