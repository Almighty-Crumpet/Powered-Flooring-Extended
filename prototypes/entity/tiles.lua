-- Powered Floor mod for Factorio
--
-- This mod adds tiles which provide power to whatever's sitting on top of them.
--
-- There's 3 items which the user gets to play with:
--
--   powered-floor-tile         provides power to objects on top of the tile.  
--                              Also transmits power to adjacent powered-floor-* things 
--                              (via powered-floor-widget, see entities file).
--
--   powered-floor-circuit-tile Provides power to objects on top of the tile  
--                              Also transmits power to adjacent powered-floor-* things
--                              and transmits red and green circuit signals to 
--                              adjacent powered-floor-circuit-tiles and powered-floor-taps 
--                              (via powered-floor-circuit-widget, see entities file)
--
--   solar-powered-floor-tile   Generates Electricity from the sun. 
--                              Also transmits pwoer to adjacent powered-floor-* things.
--                              (via powered-floor-widget, see entities file).
require("__base__/prototypes/tile/tiles.lua")

local modName = "__PoweredFloorExtended__"
local tile_collision_masks = require("__base__/prototypes/tile/tile-collision-masks")
local refined_concrete_sounds = sound_variations("__base__/sound/walking/refined-concrete", 11, 0.5)
-- Helper function to generate unique variants for each tile type
local function get_variants(style_name)
  local copy = util.table.deepcopy(data.raw["tile"]["concrete"].variants)
  copy.material_background = nil
  copy.main = {
    {
      picture = modName .. "/graphic/flooring/" .. style_name .. "/tile.png",
      count = 4,
      scale = 0.125,
      size = 1,
      line_length = 2
    }
  }
  copy.empty_transitions = false
  copy.transitions = 
  {
    overlay_layout =
    {
      side =
      {
        picture = modName .. "/graphic/Border/grid-side.png",
        count = 16,
        width = 512,
        height = 128,
        hr_version =
        {
          picture = modName .. "/graphic/Border/hr-grid-side.png",
          count = 16,
          width = 1024,
          height = 256,
          scale = 1
        }
      },
      inner_corner =
      {
        picture = modName .. "/graphic/Border/grid-inner-corner.png",
        count = 4,
        width = 128,
        height = 128,
        hr_version =
        {
          picture = modName .. "/graphic/Border/hr-grid-inner-corner.png",
          count = 4,
          width = 256,
          height = 256,
          scale = 1
        }
      },
      outer_corner =
      {
        picture = modName .. "/graphic/Border/grid-outer-corner.png",
        count = 4,
        width = 128,
        height = 128,
        hr_version =
        {
          picture = modName .. "/graphic/Border/hr-grid-outer-corner.png",
          count = 4,
          width = 256,
          height = 256,
          scale = 1
        }
      },
      u_transition =
      {
        picture = modName .. "/graphic/Border/grid-u.png",
        count = 2,
        width = 64,
        height = 128,
        hr_version =
        {
          picture = modName .. "/graphic/Border/hr-grid-u.png",
          count = 2,
          width = 128,
          height = 256,
          scale = 1
        }
      },
      o_transition =
      {
        picture = modName .. "/graphic/Border/grid-o.png",
        count = 2,
        width = 64,
        height = 32,
        hr_version =
        {
          picture = modName .. "/graphic/Border/hr-grid-o.png",
          count = 2,
          width = 128,
          height = 64,
          scale = 1
        }
      }
    }
  }
  return copy
end

data:extend({
  {
    type = "tile", name = "powered-floor-tile",
    needs_correction = false, minable = {hardness = 0.01, mining_time = 0.01, result = "powered-floor-tile"},
    mined_sound = {filename = "__base__/sound/deconstruct-bricks.ogg"},
    collision_mask = tile_collision_masks.ground(),
    walking_speed_modifier = 2.0, vehicle_speed_modifier = 2.0,
    layer = 22, layer_group = "ground-artificial", decorative_removal_probability = 1.0,
    variants = get_variants(settings.startup["powered-flooring-style"].value),
    walking_sound = refined_concrete_sounds,
    map_color = {r = 192, g = 192, b = 192}, subgroup = "artificial-tiles", order = "a[power]"
  },
  {
    type = "tile", name = "circuit-floor-tile",
    needs_correction = false, minable = {hardness = 0.01, mining_time = 0.01, result = "circuit-floor-tile"},
    mined_sound = {filename = "__base__/sound/deconstruct-bricks.ogg"},
    collision_mask = tile_collision_masks.ground(),
    walking_speed_modifier = 2, vehicle_speed_modifier = 2,
    layer = 21, layer_group = "ground-artificial", decorative_removal_probability = 1.0,
    variants = get_variants(settings.startup["circuit-flooring-style"].value),
    walking_sound = refined_concrete_sounds,
    map_color = {r = 192, g = 192, b = 192}, subgroup = "artificial-tiles", order = "b[circuit]"
  },
  {
    type = "tile", name = "solar-floor-tile",
    needs_correction = false, minable = {hardness = 0.01, mining_time = 0.01, result = "solar-floor-tile"},
    mined_sound = {filename = "__base__/sound/deconstruct-bricks.ogg"},
    collision_mask = tile_collision_masks.ground(),
    walking_speed_modifier = 0.9, vehicle_speed_modifier = 0.9,
    layer = 20, layer_group = "ground-artificial", decorative_removal_probability = 1.0,
    variants = get_variants(settings.startup["solar-flooring-style"].value),
    walking_sound = refined_concrete_sounds,
    map_color = {r = 10, g = 49, b = 94}, subgroup = "artificial-tiles", order = "c[solar]"
  },
  {
    type = "tile", name = "logistics-floor-tile",
    needs_correction = false, minable = {hardness = 0.01, mining_time = 0.01, result = "logistics-floor-tile"},
    mined_sound = {filename = "__base__/sound/deconstruct-bricks.ogg"},
    collision_mask = tile_collision_masks.ground(),
    walking_speed_modifier = 2, vehicle_speed_modifier = 2,
    layer = 23, layer_group = "ground-artificial", decorative_removal_probability = 1.0,
    variants = get_variants(settings.startup["network-flooring-style"].value),
    walking_sound = refined_concrete_sounds,
    map_color = {r = 45, g = 45, b = 45}, subgroup = "artificial-tiles", order = "d[logistics]"
  }
})