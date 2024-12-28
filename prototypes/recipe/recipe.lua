local modName = "__PoweredFloorExtended__"

data:extend({
-- Flooring
{
  type = "recipe",
  name = "powered-floor-tile",
  enabled = "false",
  ingredients =
  {
    {"copper-cable", 10},
    {"copper-plate", 1},
    {"iron-plate", 1}
  },
	energy_required = 0.5,
  result = "powered-floor-tile",
  requester_paste_multiplier = 10,
  result_count = 10
},

{
  type = "recipe",
  name = "circuit-floor-tile",
  enabled = "false",
  ingredients =
  {
    {"green-wire", 10},
    {"powered-floor-tile", 10},
    {"red-wire", 10}
  },
	energy_required = .75,
  result = "circuit-floor-tile",
  requester_paste_multiplier = 10,
  result_count = 10
},

{
  type = "recipe",
  name = "solar-floor-tile",
  enabled = "false",
  ingredients =
  {
    {"powered-floor-tile", 10},
    {"solar-panel", 1}
  },
  energy_required = 0.5,
  result = "solar-floor-tile",
  requester_paste_multiplier = 10,
  result_count = 10
},

{
  type = "recipe",
  name = "logistics-floor-tile",
  enabled = "false",
  ingredients =
  {
    {"powered-floor-tile", 20},
    {"network-node", 1}
  },
  energy_required = 0.5,
  result = "logistics-floor-tile",
  requester_paste_multiplier = 5,
  result_count = 20
},
-- Nodes
{
  type = "recipe",
  name = "network-node",
  enabled = "false",
  ingredients =
  {
    {"powered-floor-tile", 4},
    {"roboport", 1}
  },
  energy_required = 0.5,
  result = "network-node",
  requester_paste_multiplier = 5,
  result_count = 4
},

{
  type = "recipe",
  name = "construct-node",
  enabled = "false",
  ingredients =
  {
    {"powered-floor-tile", 4},
    {"roboport", 1}
  },
  energy_required = 0.5,
  result = "construct-node",
  requester_paste_multiplier = 5,
  result_count = 4
},

{
  type = "recipe",
  name = "bot-node",
  enabled = "false",
  ingredients =
  {
    {"powered-floor-tile", 4},
    {"roboport", 1}
  },
  energy_required = 0.5,
  result = "bot-node",
  requester_paste_multiplier = 5,
  result_count = 4
},
})