-- Some hidden entities that are used in this mod.  These are placed when a powered-floor-*tile is built.  
-- They actually have the wiring.
--
--   powered-floor-widget        electric-pole type
--   powered-floor-circuit-widget Same as powered-floor-widget, handled differently in control.lua
--   solar-floor-widget         Acts as a solar powered electric provider

local modName = "__PoweredFloorExtended__"
local selectedStyle = settings.startup["flooring-style"].value

data:extend({
{
  type = "electric-pole",
  name = "powered-floor-widget",
  icon = modName .. "/graphic/powered-floor-icon.png",
  icon_size = 32,
  flags = {"placeable-neutral", "player-creation","not-on-map"},
  minable = {hardness = 0.01, mining_time = 0.01, result = "powered-floor-widget"},
  max_health = 5000,
  corpse = "small-remnants",
  draw_copper_wires = false,
  resistances =
  {
    {
      type = "fire",
      percent = 100
    }
  },
  collision_mask = {"ground-tile"},
  collision_box = {{-0.15, -0.15}, {0.15, 0.15}},  -- collision mask affects effect radius somehow
  walking_speed_modifier = 2.0,
  vehicle_speed_modifier = 2.0,
  -- selection_box = {{-0.5, -0.5}, {0.5, 0.5}},   -- selection box makes it a mineable entity rather than mineable tire
  light = {intensity = 0.6, size = 6, color = {r=0.01, g=0.03, b=0.08}},drawing_box = {{0,0}, {0,0}},
  maximum_wire_distance = 1,
  max_circuit_wire_distance = 1,
  supply_area_distance = 0.5,
  vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
  pictures =
  {
    filename = modName .. "/graphic/powered-floor.png",
    priority = "low",
    width = 32,
    height = 32,
    axially_symmetrical = true,
    direction_count = 1,
    shift = {0, 0}
  },
  render_layer="water-tile",
  map_color=nil,
  connection_points =
  {
    {
      shadow =  {  copper = {0, 0}  },
      wire =    {  copper = {0, 0}  }
    }
  },
  radius_visualisation_picture =
  {
    filename = "__base__/graphics/entity/small-electric-pole/electric-pole-radius-visualization.png",
    width = 12,
    height = 12
  }
},

{
  type = "electric-pole",
  name = "powered-floor-circuit-widget",
  icon = modName .. "/graphic/powered-floor-icon.png",
  icon_size = 32,
  flags = {"placeable-neutral", "player-creation","not-on-map"},
  minable = {hardness = 0.01, mining_time = 0.01, result = "powered-floor-circuit-widget"},
  max_health = 5000,
  corpse = "small-remnants",
  draw_copper_wires = false,
  draw_circuit_wires = false,
  resistances =
  {
    {
      type = "fire",
      percent = 100
    }
  },
  collision_mask = {"ground-tile"},
  collision_box = {{-0.15, -0.15}, {0.15, 0.15}},  -- collision mask affects effect radius somehow
  walking_speed_modifier = 2.0,
  -- selection_box = {{-0.5, -0.5}, {0.5, 0.5}},   -- selection box makes it a mineable entity rather than mineable tire
  light = {intensity = 0.6, size = 6, color = {r=0.01, g=0.03, b=0.08}},drawing_box = {{0,0}, {0,0}},
  maximum_wire_distance = 1,
  max_circuit_wire_distance = 1,
  supply_area_distance = 0.5,
  vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
  pictures =
  {
    filename = modName .. "/graphic/powered-floor.png",
    priority = "low",
    width = 32,
    height = 32,
    axially_symmetrical = true,
    direction_count = 1,
    shift = {0, 0}
  },
  render_layer="water-tile",
  map_color=nil,
  connection_points =
  {
    {
      shadow =  {  copper = {0, 0}  },
      wire =    {  copper = {0, 0}  }
    }
  },
  radius_visualisation_picture =
  {
    filename = "__base__/graphics/entity/small-electric-pole/electric-pole-radius-visualization.png",
    width = 12,
    height = 12
  }
},

{
  type = "solar-panel",
  name = "solar-floor-widget",
  icon = modName .. "/graphic/powered-floor-icon.png",
  icon_size = 32,
  flags = {"placeable-neutral", "player-creation","not-on-map"},
  minable = {hardness = 0.01, mining_time = 0.01, result = "solar-floor-widget"},
  max_health = 5000,
  corpse = "small-remnants",
  draw_copper_wires = false,
  resistances =
  {
    {
      type = "fire",
      percent = 100
    }
  },
  energy_source =
  {
    type = "electric",
    usage_priority = "solar"
  },
  production = "10kW",
  collision_mask = {"ground-tile"},
  collision_box = {{-0.15, -0.15}, {0.15, 0.15}},  -- collision mask affects effect radius somehow
  walking_speed_modifier = 2.0,
  vehicle_speed_modifier = 2.0,
  -- selection_box = {{-0.5, -0.5}, {0.5, 0.5}},   -- selection box makes it a mineable entity rather than mineable tire
  light = {intensity = 0.6, size = 6, color = {r=0.01, g=0.03, b=0.08}},drawing_box = {{0,0}, {0,0}},
  vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
  picture =
  {
    filename = modName .. "/graphic/powered-floor.png",
    priority = "low",
    width = 32,
    height = 32,
    axially_symmetrical = true,
    direction_count = 1,
    shift = {0, 0}
  },
  render_layer="water-tile",
  map_color=nil
}
})
