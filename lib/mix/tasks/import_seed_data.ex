defmodule Mix.Tasks.ImportSeedData do
  use Mix.Task

  alias Bolt.Sips, as: Neo
  alias Bolt.Sips.Response

  @query ~s"""
  CREATE (n0:Node {name:'Start point1', type:'start'})
  CREATE (n1:Node {name:'Kamado', type:'shrine'})
  CREATE (n2:Node {name:'Point2', type:'point'})
  CREATE (n3:Node {name:'Point3', type:'point'})
  CREATE (n4:Node {name:'Point4', type:'point'})
  CREATE (n5:Node {name:'Point5', type:'point'})
  CREATE (n6:Node {name:'Point6', type:'point'})
  CREATE (n7:Node {name:'Point7', type:'point'})
  CREATE (n8:Node {name:'Point8', type:'point'})
  CREATE (n9:Node {name:'Torigoe pass', type:'pass'})
  CREATE (n10:Node {name:'Point10', type:'point'})
  CREATE (n11:Node {name:'Point11', type:'point'})
  CREATE (n12:Node {name:'Mt.Houman', type:'summit'})
  CREATE (n13:Node {name:'Camp center', type:'tent_area'})
  CREATE (n14:Node {name:'Point14', type:'point'})
  CREATE (n15:Node {name:'Point15', type:'point'})
  CREATE (n16:Node {name:'Point16', type:'point'})
  CREATE (n17:Node {name:'Point17', type:'point'})
  CREATE (n18:Node {name:'Point18', type:'point'})
  CREATE (n19:Node {name:'Point19', type:'point'})

  CREATE
    (n0)-[:WALK_TO {time:5}]->(n1),
    (n1)-[:WALK_TO {time:5}]->(n0),
    (n0)-[:WALK_TO {time:10}]->(n2),
    (n2)-[:WALK_TO {time:10}]->(n0),
    (n1)-[:WALK_TO {time:5}]->(n2),
    (n2)-[:WALK_TO {time:5}]->(n1),
    (n2)-[:WALK_TO {time:10}]->(n3),
    (n3)-[:WALK_TO {time:10}]->(n2),
    (n3)-[:WALK_TO {time:10}]->(n4),
    (n4)-[:WALK_TO {time:10}]->(n3),
    (n4)-[:WALK_TO {time:10}]->(n5),
    (n5)-[:WALK_TO {time:10}]->(n4),
    (n3)-[:WALK_TO {time:10}]->(n5),
    (n5)-[:WALK_TO {time:10}]->(n3),
    (n5)-[:WALK_TO {time:5}]->(n6),
    (n6)-[:WALK_TO {time:5}]->(n5),
    (n5)-[:WALK_TO {time:10}]->(n8),
    (n8)-[:WALK_TO {time:10}]->(n5),
    (n6)-[:WALK_TO {time:10}]->(n8),
    (n8)-[:WALK_TO {time:10}]->(n6),
    (n6)-[:WALK_TO {time:30}]->(n7),
    (n7)-[:WALK_TO {time:20}]->(n6),
    (n7)-[:WALK_TO {time:30}]->(n11),
    (n11)-[:WALK_TO {time:20}]->(n7),
    (n11)-[:WALK_TO {time:20}]->(n12),
    (n12)-[:WALK_TO {time:20}]->(n11),
    (n11)-[:WALK_TO {time:20}]->(n13),
    (n13)-[:WALK_TO {time:20}]->(n11),
    (n12)-[:WALK_TO {time:5}]->(n13),
    (n13)-[:WALK_TO {time:5}]->(n12),
    (n11)-[:WALK_TO {time:15}]->(n19),
    (n19)-[:WALK_TO {time:15}]->(n11),
    (n19)-[:WALK_TO {time:15}]->(n12),
    (n12)-[:WALK_TO {time:15}]->(n19),
    (n12)-[:WALK_TO {time:15}]->(n14),
    (n14)-[:WALK_TO {time:15}]->(n12),
    (n13)-[:WALK_TO {time:15}]->(n14),
    (n14)-[:WALK_TO {time:15}]->(n13),
    (n4)-[:WALK_TO {time:40}]->(n9),
    (n9)-[:WALK_TO {time:30}]->(n4),
    (n9)-[:WALK_TO {time:20}]->(n10),
    (n10)-[:WALK_TO {time:20}]->(n9),
    (n10)-[:WALK_TO {time:30}]->(n11),
    (n11)-[:WALK_TO {time:20}]->(n10),
    (n0)-[:WALK_TO {time:15}]->(n15),
    (n15)-[:WALK_TO {time:15}]->(n0),
    (n2)-[:WALK_TO {time:15}]->(n15),
    (n15)-[:WALK_TO {time:15}]->(n2),
    (n15)-[:WALK_TO {time:10}]->(n16),
    (n16)-[:WALK_TO {time:10}]->(n15),
    (n16)-[:WALK_TO {time:5}]->(n17),
    (n17)-[:WALK_TO {time:5}]->(n16),
    (n16)-[:WALK_TO {time:15}]->(n8),
    (n8)-[:WALK_TO {time:15}]->(n16),
    (n8)-[:WALK_TO {time:70}]->(n18),
    (n18)-[:WALK_TO {time:50}]->(n8),
    (n18)-[:WALK_TO {time:30}]->(n14),
    (n14)-[:WALK_TO {time:20}]->(n18)
  """

  @shortdoc "Create nodes and links."
  def run(_) do
    :ok = start_dependencies
    %Response{stats: result} = Neo.conn() |> Neo.query!(@query)
    IO.puts "Import finished in success."
    IO.inspect result
  end

  defp start_dependencies, do: Mix.Task.run("app.start")
end
