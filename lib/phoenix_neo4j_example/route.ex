defmodule PhoenixNeo4jExample.Route do
  alias Bolt.Sips, as: Neo
  alias Bolt.Sips.Response
  alias Bolt.Sips.Types.Path
  alias Bolt.Sips.Types.Node

  @routes [
    %{from: "n0", time: 5, to: "n1"},
    %{from: "n1", time: 5, to: "n0"},
    %{from: "n0", time: 10, to: "n2"},
    %{from: "n2", time: 10, to: "n0"},
    %{from: "n1", time: 5, to: "n2"},
    %{from: "n2", time: 5, to: "n1"},
    %{from: "n2", time: 10, to: "n3"},
    %{from: "n3", time: 10, to: "n2"},
    %{from: "n3", time: 10, to: "n4"},
    %{from: "n4", time: 10, to: "n3"},
    %{from: "n4", time: 10, to: "n5"},
    %{from: "n5", time: 10, to: "n4"},
    %{from: "n3", time: 10, to: "n5"},
    %{from: "n5", time: 10, to: "n3"},
    %{from: "n5", time: 5, to: "n6"},
    %{from: "n6", time: 5, to: "n5"},
    %{from: "n5", time: 10, to: "n8"},
    %{from: "n8", time: 10, to: "n5"},
    %{from: "n6", time: 10, to: "n8"},
    %{from: "n8", time: 10, to: "n6"},
    %{from: "n6", time: 30, to: "n7"},
    %{from: "n7", time: 20, to: "n6"},
    %{from: "n7", time: 30, to: "n11"},
    %{from: "n11", time: 20, to: "n7"},
    %{from: "n11", time: 20, to: "n12"},
    %{from: "n12", time: 20, to: "n11"},
    %{from: "n11", time: 20, to: "n13"},
    %{from: "n13", time: 20, to: "n11"},
    %{from: "n12", time: 5, to: "n13"},
    %{from: "n13", time: 5, to: "n12"},
    %{from: "n11", time: 15, to: "n19"},
    %{from: "n19", time: 15, to: "n11"},
    %{from: "n19", time: 15, to: "n12"},
    %{from: "n12", time: 15, to: "n19"},
    %{from: "n12", time: 15, to: "n14"},
    %{from: "n14", time: 15, to: "n12"},
    %{from: "n13", time: 15, to: "n14"},
    %{from: "n14", time: 15, to: "n13"},
    %{from: "n4", time: 40, to: "n9"},
    %{from: "n9", time: 30, to: "n4"},
    %{from: "n9", time: 20, to: "n10"},
    %{from: "n10", time: 20, to: "n9"},
    %{from: "n10", time: 30, to: "n11"},
    %{from: "n11", time: 20, to: "n10"},
    %{from: "n0", time: 15, to: "n15"},
    %{from: "n15", time: 15, to: "n0"},
    %{from: "n2", time: 15, to: "n15"},
    %{from: "n15", time: 15, to: "n2"},
    %{from: "n15", time: 10, to: "n16"},
    %{from: "n16", time: 10, to: "n15"},
    %{from: "n16", time: 5, to: "n17"},
    %{from: "n17", time: 5, to: "n16"},
    %{from: "n16", time: 15, to: "n8"},
    %{from: "n8", time: 15, to: "n16"},
    %{from: "n8", time: 70, to: "n18"},
    %{from: "n18", time: 50, to: "n8"},
    %{from: "n18", time: 30, to: "n14"},
    %{from: "n14", time: 20, to: "n18"}
  ]

  @colors ["#ff5079", "#50d1ff", "#50ff7f"]

  def search(from, to) do
    query = cyper_query(:search, from, to)
    routes =
      Neo.conn()
      |> Neo.query!(query)
      |> parse_search_result
    {:ok, routes}
  end

  defp parse_search_result(%Response{records: records}) do
    records
    |> Enum.with_index
    |> Enum.map(fn({[_from, _to, %Path{nodes: nodes}, time], i}) ->
      %{
        node_ids: Enum.map(nodes, fn(%Node{properties: %{"id" => id}}) -> id end),
        total_time: time,
        color: @colors |> Enum.at(i)
      }
    end)
  end

  def cyper_query(:create) do
    "CREATE\n" <>
      (@routes
      |> Enum.map(fn(route) ->
        "(#{route[:from]})-[:WALK_TO {time:#{route[:time]}}]->(#{route[:to]})"
      end)
      |> Enum.join(",\n"))
  end

  defp cyper_query(:search, from, to) do
    ~s"""
    MATCH (from:Node {id: '#{from}'}), (to:Node {id: '#{to}'}), path=((from)-[walk:WALK_TO*1..10]->(to))
    RETURN from, to, path,
    REDUCE(totalTime=0, w in walk | totalTime + w.time) as cost
    ORDER BY cost
    LIMIT 3
    """
  end
end
