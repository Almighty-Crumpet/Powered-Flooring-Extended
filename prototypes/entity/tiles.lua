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
local selectedStyle = settings.startup["flooring-style"].value

data:extend({
{   
  type = "tile",
  name = "powered-floor-tile",
  minable = {hardness = 0.01, mining_time = 0.01, result = "powered-floor-tile"},
  mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
  collision_mask = {"ground-tile"},
  walking_speed_modifier = 2.0,
  vehicle_speed_modifier = 2.0,
  light = {intensity = 0.6, size = 6, color = {r=0.01, g=0.03, b=0.08}},drawing_box = {{0,0}, {0,0}},
  layer = 66,
  decorative_removal_probability = 1.0,
  variants =
  {
    main =
    {
      {
        picture = modName .. "/graphic/" .. selectedStyle .. "/grid-1.png",
        count = 16,
        size = 1,
        hr_version = 
        {
          picture = modName .. "/graphic/" .. selectedStyle .. "/hr-grid-1.png",
          count = 16,
          scale = 0.5
        },
      }
    },
    inner_corner =
    {
      picture = modName .. "/graphic/" .. selectedStyle .. "/border/grid-inner-corner.png",
      count = 4,
      hr_version = 
      {
        picture = modName .. "/graphic/" .. selectedStyle .. "/border/hr-grid-inner-corner.png",
        count = 4,
        scale = 0.5
      },
    },

    outer_corner =
    {
      picture = modName .. "/graphic/" .. selectedStyle .. "/border/grid-outer-corner.png",
      count = 4,
      hr_version = 
      {
        picture = modName .. "/graphic/" .. selectedStyle .. "/border/hr-grid-outer-corner.png",
        count = 4,
        scale = 0.5
      },
    },

    side =
    {
      picture = modName .. "/graphic/" .. selectedStyle .. "/border/grid-side.png",
      count = 16,
      hr_version = 
      {
        picture = modName .. "/graphic/" .. selectedStyle .. "/border/hr-grid-side.png",
        count = 16,
        scale = 0.5
      },
    },

    u_transition =
    {
      picture = modName .. "/graphic/" .. selectedStyle .. "/border/grid-u.png",
      count = 2,
      hr_version = 
      {
        picture = modName .. "/graphic/" .. selectedStyle .. "/border/hr-grid-u.png",
        count = 2,
        scale = 0.5
      },
    },

    o_transition =
    {
      picture = modName .. "/graphic/" .. selectedStyle .. "/border/grid-o.png",
      count = 2,
      hr_version = 
      {
        picture = modName .. "/graphic/" .. selectedStyle .. "/border/hr-grid-o.png",
        count = 2,
        scale = 0.5
      },
    },
  },
  walking_sound =
  {
    {
      filename = "__base__/sound/walking/concrete-01.ogg",
      volume = 1.2
    },
    {
      filename = "__base__/sound/walking/concrete-02.ogg",
      volume = 1.2
    },
    {
      filename = "__base__/sound/walking/concrete-03.ogg",
      volume = 1.2
    },
    {
      filename = "__base__/sound/walking/concrete-04.ogg",
      volume = 1.2
    }
  },
  map_color={r=192, g=192, b=192},
  pollution_absorption_per_second=0,
},

{   
  type = "tile",
  name = "powered-floor-circuit-tile",
  minable = {hardness = 0.01, mining_time = 0.01, result = "powered-floor-circuit-tile"},
  mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
  collision_mask = {"ground-tile"},
  walking_speed_modifier = 2.0,
  vehicle_speed_modifier = 2.0,
  light = {intensity = 0.6, size = 6, color = {r=0.01, g=0.03, b=0.08}},drawing_box = {{0,0}, {0,0}},
  layer = 67,
  decorative_removal_probability = 0.05,
  variants =
  {
    main =
    {
      {
        picture = modName .. "/graphic/" .. selectedStyle .. "/grid-2.png",
        count = 16,
        size = 1,
        hr_version = 
        {
          picture = modName .. "/graphic/" .. selectedStyle .. "/hr-grid-2.png",
          count = 16,
          scale = 0.5
        },
      }
    },
    
    inner_corner =
    {
      picture = modName .. "/graphic/" .. selectedStyle .. "/border/grid-inner-corner.png",
      count = 4,
      hr_version = 
      {
        picture = modName .. "/graphic/" .. selectedStyle .. "/border/hr-grid-inner-corner.png",
        count = 4,
        scale = 0.5
      },
    },

    outer_corner =
    {
      picture = modName .. "/graphic/" .. selectedStyle .. "/border/grid-outer-corner.png",
      count = 4,
      hr_version = 
      {
        picture = modName .. "/graphic/" .. selectedStyle .. "/border/hr-grid-outer-corner.png",
        count = 4,
        scale = 0.5
      },
    },

    side =
    {
      picture = modName .. "/graphic/" .. selectedStyle .. "/border/grid-side.png",
      count = 16,
      hr_version = 
      {
        picture = modName .. "/graphic/" .. selectedStyle .. "/border/hr-grid-side.png",
        count = 16,
        scale = 0.5
      },
    },

    u_transition =
    {
      picture = modName .. "/graphic/" .. selectedStyle .. "/border/grid-u.png",
      count = 2,
      hr_version = 
      {
        picture = modName .. "/graphic/" .. selectedStyle .. "/border/hr-grid-u.png",
        count = 2,
        scale = 0.5
      },
    },

    o_transition =
    {
      picture = modName .. "/graphic/" .. selectedStyle .. "/border/grid-o.png",
      count = 2,
      hr_version = 
      {
        picture = modName .. "/graphic/" .. selectedStyle .. "/border/hr-grid-o.png",
        count = 2,
        scale = 0.5
      },
    },
  },
  walking_sound =
  {
    {
      filename = "__base__/sound/walking/concrete-01.ogg",
      volume = 1.2
    },
    {
      filename = "__base__/sound/walking/concrete-02.ogg",
      volume = 1.2
    },
    {
      filename = "__base__/sound/walking/concrete-03.ogg",
      volume = 1.2
    },
    {
      filename = "__base__/sound/walking/concrete-04.ogg",
      volume = 1.2
    }
  },
  map_color={r=192, g=192, b=192},
  pollution_absorption_per_second=0
},

{   
  type = "tile",
  name = "solar-powered-floor-tile",
  minable = {hardness = 0.01, mining_time = 0.01, result = "solar-powered-floor-tile"},
  mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
  collision_mask = {"ground-tile"},
  walking_speed_modifier = 0.3,
  vehicle_speed_modifier = 0.3,
  light = {intensity = 0.6, size = 6, color = {r=0.01, g=0.03, b=0.08}},drawing_box = {{0,0}, {0,0}},
  layer = 68,
  decorative_removal_probability = 1.0,
  variants =
  {
    main =
    {
      {
        picture = modName .. "/graphic/" .. selectedStyle .. "/grid-3.png",
        count = 16,
        size = 1,
        hr_version = 
        {
          picture = modName .. "/graphic/" .. selectedStyle .. "/hr-grid-3.png",
          count = 16,
          scale = 0.5
        },
      }
    },
    
    inner_corner =
    {
      picture = modName .. "/graphic/" .. selectedStyle .. "/border/grid-inner-corner.png",
      count = 4,
      hr_version = 
      {
        picture = modName .. "/graphic/" .. selectedStyle .. "/border/hr-grid-inner-corner.png",
        count = 4,
        scale = 0.5
      },
    },

    outer_corner =
    {
      picture = modName .. "/graphic/" .. selectedStyle .. "/border/grid-outer-corner.png",
      count = 4,
      hr_version = 
      {
        picture = modName .. "/graphic/" .. selectedStyle .. "/border/hr-grid-outer-corner.png",
        count = 4,
        scale = 0.5
      },
    },

    side =
    {
      picture = modName .. "/graphic/" .. selectedStyle .. "/border/grid-side.png",
      count = 16,
      hr_version = 
      {
        picture = modName .. "/graphic/" .. selectedStyle .. "/border/hr-grid-side.png",
        count = 16,
        scale = 0.5
      },
    },

    u_transition =
    {
      picture = modName .. "/graphic/" .. selectedStyle .. "/border/grid-u.png",
      count = 2,
      hr_version = 
      {
        picture = modName .. "/graphic/" .. selectedStyle .. "/border/hr-grid-u.png",
        count = 2,
        scale = 0.5
      },
    },

    o_transition =
    {
      picture = modName .. "/graphic/" .. selectedStyle .. "/border/grid-o.png",
      count = 2,
      hr_version = 
      {
        picture = modName .. "/graphic/" .. selectedStyle .. "/border/hr-grid-o.png",
        count = 2,
        scale = 0.5
      },
    },
  },
  walking_sound =
  {
    {
      filename = "__base__/sound/walking/concrete-01.ogg",
      volume = 1.2
    },
    {
      filename = "__base__/sound/walking/concrete-02.ogg",
      volume = 1.2
    },
    {
      filename = "__base__/sound/walking/concrete-03.ogg",
      volume = 1.2
    },
    {
      filename = "__base__/sound/walking/concrete-04.ogg",
      volume = 1.2
    }
  },
  map_color={r=10, g=49, b=94},
  pollution_absorption_per_second=0
}
})
