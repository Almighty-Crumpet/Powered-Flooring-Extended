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
local tile_variants = {
  main = {{picture = "__base__/graphics/terrain/concrete/concrete.png", count = 16, size = 1, scale = 0.5}},
  transition = {inner_corner = {}, outer_corner = {}, side = {}, u_transition = {}},
  transitions = {},
  transitions_between_transitions = {},
  overlay_layout = {
    inner_corner = {spritesheet = "__base__/graphics/terrain/concrete/concrete-inner-corner.png", count = 16, scale = 0.5},
    outer_corner = {spritesheet = "__base__/graphics/terrain/concrete/concrete-outer-corner.png", count = 8, scale = 0.5},
    side = {spritesheet = "__base__/graphics/terrain/concrete/concrete-side.png", count = 16, scale = 0.5},
    u_transition = {spritesheet = "__base__/graphics/terrain/concrete/concrete-u.png", count = 8, scale = 0.5},
    o_transition = {spritesheet = "__base__/graphics/terrain/concrete/concrete-o.png", count = 4, scale = 0.5}
  },
  mask_layout = {
    inner_corner = {spritesheet = "__base__/graphics/terrain/concrete/concrete-inner-corner-mask.png", count = 16, scale = 0.5},
    outer_corner = {spritesheet = "__base__/graphics/terrain/concrete/concrete-outer-corner-mask.png", count = 8, scale = 0.5},
    side = {spritesheet = "__base__/graphics/terrain/concrete/concrete-side-mask.png", count = 16, scale = 0.5},
    u_transition = {spritesheet = "__base__/graphics/terrain/concrete/concrete-u-mask.png", count = 8, scale = 0.5},
    o_transition = {spritesheet = "__base__/graphics/terrain/concrete/concrete-o-mask.png", count = 4, scale = 0.5}
  }
}

data:extend({
  {
    type = "tile", name = "powered-floor-tile",
    needs_correction = false, minable = {hardness = 0.01, mining_time = 0.01, result = "powered-floor-tile"},
    mined_sound = {filename = "__base__/sound/deconstruct-bricks.ogg"},
    collision_mask = tile_collision_masks.ground(),
    walking_speed_modifier = 2.0, vehicle_speed_modifier = 2.0,
    layer = 20, layer_group = "ground-artificial", decorative_removal_probability = 1.0,
    variants = {main = {{picture = modName .. "/graphic/Flooring/" .. settings.startup["powered-flooring-style"].value .. "/tile.png", count = 8, size = 1, scale = 0.25}}, transition = tile_variants},
    transitions = concrete_transitions, transitions_between_transitions = concrete_transitions_between_transitions,
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
    variants = {main = {{picture = modName .. "/graphic/Flooring/" .. settings.startup["circuit-flooring-style"].value .. "/tile.png", count = 16, size = 1, scale = 0.5}}, transition = tile_variants},
    transitions = concrete_transitions, transitions_between_transitions = concrete_transitions_between_transitions,
    walking_sound = refined_concrete_sounds,
    map_color = {r = 192, g = 192, b = 192}, subgroup = "artificial-tiles", order = "b[circuit]"
  },
  {
    type = "tile", name = "solar-floor-tile",
    needs_correction = false, minable = {hardness = 0.01, mining_time = 0.01, result = "solar-floor-tile"},
    mined_sound = {filename = "__base__/sound/deconstruct-bricks.ogg"},
    collision_mask = tile_collision_masks.ground(),
    walking_speed_modifier = 0.9, vehicle_speed_modifier = 0.9,
    layer = 22, layer_group = "ground-artificial", decorative_removal_probability = 1.0,
    variants = {main = {{picture = modName .. "/graphic/Flooring/" .. settings.startup["solar-flooring-style"].value .. "/tile.png", count = 8, size = 1, scale = 0.25}}, transition = tile_variants},
    transitions = concrete_transitions, transitions_between_transitions = concrete_transitions_between_transitions,
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
    variants = {main = {{picture = modName .. "/graphic/Flooring/" .. settings.startup["network-flooring-style"].value .. "/tile.png", count = 8, size = 1, scale = 0.25}}, transition = tile_variants},
    transitions = concrete_transitions, transitions_between_transitions = concrete_transitions_between_transitions,
    walking_sound = refined_concrete_sounds,
    map_color = {r = 10, g = 49, b = 94}, subgroup = "artificial-tiles", order = "d[logistics]"
  }
})