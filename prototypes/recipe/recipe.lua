local modName = "__PoweredFloorExtended__"
local selectedStyle = settings.startup["flooring-style"].value

data:extend({
{
  type = "recipe",
  name = "powered-floor-tap",
  enabled = "false",
  ingredients =
  {
    {"electronic-circuit", 1},
    {"copper-cable", 1},
    {"copper-plate", 1},
    {"green-wire", 1},
    {"iron-plate", 1},
    {"red-wire", 1}
  },
	energy_required = 1,
  result = "powered-floor-tap",
  requester_paste_multiplier = 10,
  result_count = 1
},

{
  type = "recipe",
  name = "powered-floor-circuit-tile",
  enabled = "false",
  ingredients =
  {
    {"green-wire", 10},
    {"powered-floor-tile", 10},
    {"red-wire", 10}
  },
	energy_required = .75,
  result = "powered-floor-circuit-tile",
  requester_paste_multiplier = 10,
  result_count = 10
},

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
  name = "solar-powered-floor-tile",
  enabled = "false",
  ingredients =
  {
    {"powered-floor-tile", 10},
    {"solar-panel", 1}
  },
  energy_required = 0.5,
  result = "solar-powered-floor-tile",
  requester_paste_multiplier = 10,
  result_count = 10
},
})
