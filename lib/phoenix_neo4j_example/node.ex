defmodule PhoenixNeo4jExample.Node do
  @nodes [
    %{id: "n0", name: "Start point1", type: :start, location: [33.528848, 130.550508]},
    %{id: "n1", name: "Kamado", type: :shrine, location: [33.528770, 130.551892]},
    %{id: "n2", name: "Point2", type: :point, location: [33.530103, 130.552889]},
    %{id: "n3", name: "Point3", type: :point, location: [33.531860, 130.554847]},
    %{id: "n4", name: "Point4", type: :point, location: [33.532129, 130.558291]},
    %{id: "n5", name: "Point5", type: :point, location: [33.533855, 130.557969]},
    %{id: "n6", name: "Point6", type: :point, location: [33.534633, 130.559879]},
    %{id: "n7", name: "Point7", type: :point, location: [33.536606, 130.563079]},
    %{id: "n8", name: "Point8", type: :point, location: [33.537040, 130.558155]},
    %{id: "n9", name: "Torigoe pass", type: :pass, location: [33.530976, 130.565386]},
    %{id: "n10", name: "Point10", type: :point, location: [33.533420, 130.566517]},
    %{id: "n11", name: "Point11", type: :point, location: [33.536570, 130.567285]},
    %{id: "n12", name: "Mt.Houman", type: :summit, location: [33.539794, 130.568926]},
    %{id: "n13", name: "Camp center", type: :tent_area, location: [33.540331, 130.570107]},
    %{id: "n14", name: "Point14", type: :point, location: [33.542101, 130.571651]},
    %{id: "n15", name: "Point15", type: :point, location: [33.533409, 130.550215]},
    %{id: "n16", name: "Point16", type: :point, location: [33.535627, 130.554292]},
    %{id: "n17", name: "Point17", type: :point, location: [33.536217, 130.554013]},
    %{id: "n18", name: "Point18", type: :point, location: [33.545124, 130.565557]},
    %{id: "n19", name: "Point19", type: :point, location: [33.541261, 130.567124]}
  ]

  def list do
    {:ok, @nodes}
  end

  def cyper_query(:create) do
    @nodes
    |> Enum.map(fn(node) ->
      "CREATE (#{node[:id]}:Node {id:'#{node[:id]}', name:'#{node[:name]}', type:'#{node[:type]}'})"
    end)
    |> Enum.join("\n")
  end
end
