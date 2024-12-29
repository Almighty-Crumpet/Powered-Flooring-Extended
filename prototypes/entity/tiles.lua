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

local modName = "__PoweredFloorExtended__"
local tile_collision_masks = require("__base__/prototypes/tile/tile-collision-masks")
local tile_transitions = require("__base__/prototypes/tile/tiles")
local refined_concrete_sounds = sound_variations("__base__/sound/walking/refined-concrete", 11, 0.5)

data:extend({
{   
  type = "tile",
  name = "powered-floor-tile",
  needs_correction = false,
  minable = {hardness = 0.01, mining_time = 0.01, result = "powered-floor-tile"},
  mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
  collision_mask = tile_collision_masks.ground(),
  walking_speed_modifier = 2.0,
  vehicle_speed_modifier = 2.0,
  light = {intensity = 0.6, size = 6, color = {r=0.01, g=0.03, b=0.08}},drawing_box = {{0,0}, {0,0}},
  layer = 20,
  layer_group = "ground-artificial",
  decorative_removal_probability = 1.0,
  variants =
  {
    main =
    {{
      picture = modName .. "/graphic/Flooring/" .. settings.startup["powered-flooring-style"].value .. "/hr-tile.png",
      count = 16,
      size = 1,
      scale = 0.5
    },},
    empty_transitions = true,
    transition = 
    {
      overlay_layout =
      {
        inner_corner =
        {
          spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["powered-flooring-style"].value .. "/border/grid-inner-corner.png",
          count = 4,
          hr_version = 
          {
            spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["powered-flooring-style"].value .. "/border/hr-grid-inner-corner.png",
            count = 4,
            scale = 1
          },
        },
        outer_corner =
        {
          spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["powered-flooring-style"].value .. "/border/grid-outer-corner.png",
          count = 4,
          hr_version = 
          {
            spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["powered-flooring-style"].value .. "/border/hr-grid-outer-corner.png",
            count = 4,
            scale = 1
          },
        },
        side =
        {
          spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["powered-flooring-style"].value .. "/border/grid-side.png",
          count = 16,
          hr_version = 
          {
            spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["powered-flooring-style"].value .. "/border/hr-grid-side.png",
            count = 16,
            scale = 1
          },
        },
        u_transition =
        {
          spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["powered-flooring-style"].value .. "/border/grid-u.png",
          count = 2,
          hr_version = 
          {
            spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["powered-flooring-style"].value .. "/border/hr-grid-u.png",
            count = 2,
            scale = 1
          },
        },
        o_transition =
        {
          spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["powered-flooring-style"].value .. "/border/grid-o.png",
          count = 2,
          hr_version = 
          {
            spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["powered-flooring-style"].value .. "/border/hr-grid-o.png",
            count = 2,
            scale = 1
          },
        },
      },
    },
  },

  transitions = concrete_transitions,
  transitions_between_transitions = concrete_transitions_between_transitions,

  walking_sound = refined_concrete_sounds,

  map_color={r=192, g=192, b=192},
},

{   
  type = "tile",
  name = "circuit-floor-tile",
  needs_correction = false,
  minable = {hardness = 0.01, mining_time = 0.01, result = "circuit-floor-tile"},
  mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
  collision_mask = tile_collision_masks.ground(),
  walking_speed_modifier = 2.0,
  vehicle_speed_modifier = 2.0,
  light = {intensity = 0.6, size = 6, color = {r=0.01, g=0.03, b=0.08}},drawing_box = {{0,0}, {0,0}},
  layer = 21,
  layer_group = "ground-artificial",
  decorative_removal_probability = 0.05,
  variants =
  {
    main =
    {
      {
        picture = modName .. "/graphic/Flooring/" .. settings.startup["circuit-flooring-style"].value .. "/hr-tile.png",
        count = 16,
        size = 1,
        scale = 0.5
      },
    },
    empty_transitions = true,
    transition = 
    {
      overlay_layout = 
      {
        inner_corner =
        {
          spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["circuit-flooring-style"].value .. "/border/grid-inner-corner.png",
          count = 4,
          hr_version = 
          {
            spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["circuit-flooring-style"].value .. "/border/hr-grid-inner-corner.png",
            count = 4,
            scale = 0.5
          },
        },
        outer_corner =
        {
          spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["circuit-flooring-style"].value .. "/border/grid-outer-corner.png",
          count = 4,
          hr_version = 
          {
            spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["circuit-flooring-style"].value .. "/border/hr-grid-outer-corner.png",
            count = 4,
            scale = 0.5
          },
        },
        side =
        {
          spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["circuit-flooring-style"].value .. "/border/grid-side.png",
          count = 16,
          hr_version = 
          {
            spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["circuit-flooring-style"].value .. "/border/hr-grid-side.png",
            count = 16,
            scale = 0.5
          },
        },
        u_transition =
        {
          spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["circuit-flooring-style"].value .. "/border/grid-u.png",
          count = 2,
          hr_version = 
          {
            spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["circuit-flooring-style"].value .. "/border/hr-grid-u.png",
            count = 2,
            scale = 0.5
          },
        },
        o_transition =
        {
          spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["circuit-flooring-style"].value .. "/border/grid-o.png",
          count = 2,
          hr_version = 
          {
            spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["circuit-flooring-style"].value .. "/border/hr-grid-o.png",
            count = 2,
            scale = 0.5
          },
        },
      },
    },
  },

  transitions = concrete_transitions,
  transitions_between_transitions = concrete_transitions_between_transitions,

  walking_sound = refined_concrete_sounds,
  map_color={r=192, g=192, b=192},
},

{   
  type = "tile",
  name = "solar-floor-tile",
  needs_correction = false,
  minable = {hardness = 0.01, mining_time = 0.01, result = "solar-floor-tile"},
  mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
  collision_mask = tile_collision_masks.ground(),
  walking_speed_modifier = 0.3,
  vehicle_speed_modifier = 0.3,
  light = {intensity = 0.6, size = 6, color = {r=0.01, g=0.03, b=0.08}},drawing_box = {{0,0}, {0,0}},
  layer = 22,
  layer_group = "ground-artificial",
  decorative_removal_probability = 1.0,
  variants =
  {
    main =
    {
      {
        picture = modName .. "/graphic/Flooring/" .. settings.startup["solar-flooring-style"].value .. "/hr-tile.png",
        count = 16,
        size = 1,
        scale = 0.5
      },
    },
    empty_transitions = true,
    transition = 
    {
      overlay_layout =
      {
        inner_corner =
        {
          spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["solar-flooring-style"].value .. "/border/grid-inner-corner.png",
          count = 4,
          hr_version = 
          {
            spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["solar-flooring-style"].value .. "/border/hr-grid-inner-corner.png",
            count = 4,
            scale = 0.5
          },
        },
        outer_corner =
        {
          spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["solar-flooring-style"].value .. "/border/grid-outer-corner.png",
          count = 4,
          hr_version = 
          {
            spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["solar-flooring-style"].value .. "/border/hr-grid-outer-corner.png",
            count = 4,
            scale = 0.5
          },
        },
        side =
        {
          spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["solar-flooring-style"].value .. "/border/grid-side.png",
          count = 16,
          hr_version = 
          {
            spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["solar-flooring-style"].value .. "/border/hr-grid-side.png",
            count = 16,
            scale = 0.5
          },
        },
        u_transition =
        {
          spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["solar-flooring-style"].value .. "/border/grid-u.png",
          count = 2,
          hr_version = 
          {
            spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["solar-flooring-style"].value .. "/border/hr-grid-u.png",
            count = 2,
            scale = 0.5
          },
        },
        o_transition =
        {
          spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["solar-flooring-style"].value .. "/border/grid-o.png",
          count = 2,
          hr_version = 
          {
            spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["solar-flooring-style"].value .. "/border/hr-grid-o.png",
            count = 2,
            scale = 0.5
          },
        },
      },
    },
  },

  transitions = concrete_transitions,
  transitions_between_transitions = concrete_transitions_between_transitions,

  walking_sound = refined_concrete_sounds,
  map_color={r=10, g=49, b=94},
},

{   
  type = "tile",
  name = "logistics-floor-tile",
  needs_correction = false,
  minable = {hardness = 0.01, mining_time = 0.01, result = "logistics-floor-tile"},
  mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
  collision_mask = tile_collision_masks.ground(),
  walking_speed_modifier = 0.3,
  vehicle_speed_modifier = 0.3,
  light = {intensity = 0.6, size = 6, color = {r=0.01, g=0.03, b=0.08}},drawing_box = {{0,0}, {0,0}},
  layer = 23,
  layer_group = "ground-artificial",
  decorative_removal_probability = 1.0,
  variants =
  {
    main =
    {
      {
        picture = modName .. "/graphic/Flooring/" .. settings.startup["network-flooring-style"].value .. "/hr-tile.png",
        count = 16,
        size = 1,
        scale = 0.5
      },
    },
    empty_transitions = true,
    transition = 
    {
      overlay_layout =
      {
        inner_corner =
        {
          spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["network-flooring-style"].value .. "/border/grid-inner-corner.png",
          count = 4,
          hr_version = 
          {
            spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["network-flooring-style"].value .. "/border/hr-grid-inner-corner.png",
            count = 4,
            scale = 0.5
          },
        },
        outer_corner =
        {
          spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["network-flooring-style"].value .. "/border/grid-outer-corner.png",
          count = 4,
          hr_version = 
          {
            spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["network-flooring-style"].value .. "/border/hr-grid-outer-corner.png",
            count = 4,
            scale = 0.5
          },
        },
        side =
        {
          spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["network-flooring-style"].value .. "/border/grid-side.png",
          count = 16,
          hr_version = 
          {
            spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["network-flooring-style"].value .. "/border/hr-grid-side.png",
            count = 16,
            scale = 0.5
          },
        },
        u_transition =
        {
          spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["network-flooring-style"].value .. "/border/grid-u.png",
          count = 2,
          hr_version = 
          {
            spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["network-flooring-style"].value .. "/border/hr-grid-u.png",
            count = 2,
            scale = 0.5
          },
        },
        o_transition =
        {
          spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["network-flooring-style"].value .. "/border/grid-o.png",
          count = 2,
          hr_version = 
          {
            spritesheet = modName .. "/graphic/Flooring/" .. settings.startup["network-flooring-style"].value .. "/border/hr-grid-o.png",
            count = 2,
            scale = 0.5
          },
        },
      },
    },
  },
  walking_sound = refined_concrete_sounds,
  map_color={r=10, g=49, b=94},
}
})