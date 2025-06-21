local modName = "__PoweredFloorExtended__"

data:extend({
-- Flooring
{
  type = "recipe",
  name = "powered-floor-tile",
  enabled = false,
  ingredients =
  {
    {type = "item", name = "copper-cable", amount = 10},
    {type = "item", name = "copper-plate", amount = 1},
    {type = "item", name = "iron-plate", amount = 1}
  },
	energy_required = 0.5,
  results = {{type = "item", name = "powered-floor-tile", amount = 10}},
  requester_paste_multiplier = 10
},

{
  type = "recipe",
  name = "circuit-floor-tile",
  enabled = false,
  ingredients =
  {
    {type = "item", name = "copper-wire", amount = 20},
    {type = "item", name = "powered-floor-tile", amount = 10},
  },
	energy_required = .75,
  results = {{type = "item", name = "circuit-floor-tile", amount = 10}},
  requester_paste_multiplier = 10
},

{
  type = "recipe",
  name = "solar-floor-tile",
  enabled = false,
  ingredients =
  {
    {type = "item", name = "powered-floor-tile", amount = 10},
    {type = "item", name = "solar-panel", amount = 1}
  },
  energy_required = 0.5,
  results = {{type = "item", name = "solar-floor-tile", amount = 10}},
  requester_paste_multiplier = 10
},

{
  type = "recipe",
  name = "logistics-floor-tile",
  enabled = false,
  ingredients =
  {
    {type = "item", name = "powered-floor-tile", amount = 20},
    {type = "item", name = "network-node", amount = 1}
  },
  energy_required = 0.5,
  results = {{type = "item", name = "logistics-floor-tile", amount = 20}},
  requester_paste_multiplier = 5
},
-- Nodes
{
  type = "recipe",
  name = "network-node",
  enabled = false,
  ingredients =
  {
    {type = "item", name = "powered-floor-tile", amount = 4},
    {type = "item", name = "roboport", amount = 1}
  },
  energy_required = 0.5,
  results = {{type = "item", name = "network-node", amount = 4}},
  requester_paste_multiplier = 5
},

{
  type = "recipe",
  name = "construct-node",
  enabled = false,
  ingredients =
  {
    {type = "item", name = "powered-floor-tile", amount = 4},
    {type = "item", name = "roboport", amount = 1}
  },
  energy_required = 0.5,
  results = {{type = "item", name = "construct-node", amount = 4}},
  requester_paste_multiplier = 5
},

{
  type = "recipe",
  name = "bot-node",
  enabled = false,
  ingredients =
  {
    {type = "item", name = "powered-floor-tile", amount = 4},
    {type = "item", name = "roboport", amount = 1}
  },
  energy_required = 0.5,
  results = {{type = "item", name = "bot-node", amount = 4}},
  requester_paste_multiplier = 5
}

})