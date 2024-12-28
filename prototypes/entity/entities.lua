-- Some hidden entities that are used in this mod.  These are placed when a powered-floor-*tile is built.  
-- They actually have the wiring.
--
--   powered-floor-widget        electric-pole type
--   powered-floor-circuit-widget Same as powered-floor-widget, handled differently in control.lua
--   solar-floor-widget         Acts as a solar powered electric provider

local modName = "__PoweredFloorExtended__"
local blank_image = {
  direction_count = 1,
  filename = modName .. "/graphic/blank.png",
  width = 1,
  height = 1,
  frame_count = 1,
  line_length = 1,
  shift = { 0, 0 },
}

-- Widgets
data:extend ({
{
  type = "electric-pole",
  name = "powered-floor-widget",
  icon = modName .. "/graphic/powered-floor-icon.png",
  icon_size = 32,
  flags = {
    "not-blueprintable",
    "placeable-neutral",
    "player-creation",
    "not-on-map"
  },
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
  render_layer="floor",
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
  flags = {
    "not-blueprintable",
    "placeable-neutral",
    "player-creation",
    "not-on-map"
  },
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
  render_layer="floor",
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
  flags = {
    "not-blueprintable",
    "placeable-neutral",
    "player-creation",
    "not-on-map"
  },
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
  render_layer="floor",
  map_color=nil
},

{
  type = "roboport",
  name = "logistics-floor-widget",
  icon = modName .. "/graphic/powered-floor-icon.png",
  icon_size = 32,
  flags = {
    "not-blueprintable",
    "placeable-neutral",
    "player-creation",
    "not-on-map"
  },
  minable = {mining_time = 0.1, result = "logistics-floor-widget"},
  max_health = 5000,
  corpse = "small-remnants",
  collision_mask = {"ground-tile"},
  collision_box = {{-0.15, -0.15}, {0.15, 0.15}},
  resistances =
  {
    {
      type = "fire",
      percent = 100
    },
    {
      type = "impact",
      percent = 30
    }
  },
  energy_source =
  {
    type = "electric",
    usage_priority = "secondary-input",
    input_flow_limit = "5MW",
    buffer_capacity = "100MJ"
  },
  recharge_minimum = "40MJ",
  energy_usage = "50kW",
  -- per one charge slot
  charging_energy = "1000kW",
  logistics_radius = 0.5,
  construction_radius = 0,
  charge_approach_distance = 5,
  robot_slots_count = 0,
  material_slots_count = 0,
  stationing_offset = {0, 0},
  charging_offsets =
  {
    {-1.5, -0.5}, {1.5, -0.5}, {1.5, 1.5}, {-1.5, 1.5}
  },
  base = blank_image,
  base_patch = blank_image,
  base_animation = blank_image,
  door_animation_up = blank_image,
  door_animation_down = blank_image,
  recharging_animation = blank_image,
  vehicle_impact_sound = {
    {
      filename = "__base__/sound/car-metal-impact.ogg",
      volume = 0.5
    },
    {
      filename = "__base__/sound/car-metal-impact-2.ogg",
      volume = 0.5
    },
    {
      filename = "__base__/sound/car-metal-impact-3.ogg",
      volume = 0.5
    },
    {
      filename = "__base__/sound/car-metal-impact-4.ogg",
      volume = 0.5
    },
    {
      filename = "__base__/sound/car-metal-impact-5.ogg",
      volume = 0.5
    },
    {
      filename = "__base__/sound/car-metal-impact-6.ogg",
      volume = 0.5
    }
  },
  working_sound =
  {
    sound = { filename = "__base__/sound/roboport-working.ogg", volume = 0.4 },
    max_sounds_per_type = 3,
    audible_distance_modifier = 0.75,
    --probability = 1 / (5 * 60) -- average pause between the sound is 5 seconds
  },
  recharging_light = {intensity = 0.2, size = 3, color = {r = 0.5, g = 0.5, b = 1.0}},
  request_to_open_door_timeout = 15,
  spawn_and_station_height = -0.1,
  draw_logistic_radius_visualization = true,
  draw_construction_radius_visualization = true,
  water_reflection =
  {
    pictures =
    {
      filename = "__base__/graphics/entity/roboport/roboport-reflection.png",
      priority = "extra-high",
      width = 28,
      height = 28,
      shift = util.by_pixel(0, 75),
      variation_count = 1,
      scale = 5
    },
    rotate = false,
    orientation_to_variation = false
  }
}

})

-- Nodes
data:extend ({
  {
    type = "roboport",
    name = "network-node",
    icon = "__base__/graphics/icons/roboport.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {
      "placeable-player", 
      "player-creation"
    },
    minable = {mining_time = 0.1, result = "network-node"},
    max_health = 500,
    corpse = "roboport-remnants",
    dying_explosion = "roboport-explosion",
    collision_box = {{-0.7, -0.7}, {0.7, 0.7}},
    selection_box = {{-1, -1}, {1, 1}},
    damaged_trigger_effect = {
      entity_name = "spark-explosion",
      offset_deviation = {{-0.5,-0.5},{0.5,0.5}},
      offsets = {{0,1}},
      type = "create-entity"
    },
    resistances =
    {
      {
        type = "fire",
        percent = 60
      },
      {
        type = "impact",
        percent = 30
      }
    },
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      input_flow_limit = "10MW",
      buffer_capacity = "10MJ"
    },
    recharge_minimum = "40MJ",
    energy_usage = "100kW",
    -- per one charge slot
    charging_energy = "1000kW",
    logistics_radius = 20,
    construction_radius = 0,
    charge_approach_distance = 5,
    robot_slots_count = 0,
    material_slots_count = 0,
    stationing_offset = {0, 0},
    charging_offsets =
    {
      {-1.5, -0.5}, {1.5, -0.5}, {1.5, 1.5}, {-1.5, 1.5}
    },
    base =
    {
      layers =
      {
        {
          filename = modName .. "/graphic/Nodes/base.png",
          width = 1000,
          height = 1000,
          scale = 0.12,
          hr_version =
          {
            filename = modName .. "/graphic/Nodes/base.png",
            width = 1000,
            height = 1000,
            scale = 0.12
          }
        },
        {
          filename = modName .. "/graphic/Nodes/Network/node-shadow.png",
          width = 352,
          height = 352,
          draw_as_shadow = true,
          scale = 0.5,
          hr_version =
          {
            filename = modName .. "/graphic/Nodes/Network/node-shadow.png",
            width = 352,
            height = 352,
            draw_as_shadow = true,
            force_hr_shadow = true,
            scale = 0.5
          }
        }
      }
    },
    base_patch = blank_image,
    base_animation = blank_image,
    door_animation_up = blank_image,
    door_animation_down = blank_image,
    recharging_animation = blank_image,
    vehicle_impact_sound = {
      {
        filename = "__base__/sound/car-metal-impact.ogg",
        volume = 0.5
      },
      {
        filename = "__base__/sound/car-metal-impact-2.ogg",
        volume = 0.5
      },
      {
        filename = "__base__/sound/car-metal-impact-3.ogg",
        volume = 0.5
      },
      {
        filename = "__base__/sound/car-metal-impact-4.ogg",
        volume = 0.5
      },
      {
        filename = "__base__/sound/car-metal-impact-5.ogg",
        volume = 0.5
      },
      {
        filename = "__base__/sound/car-metal-impact-6.ogg",
        volume = 0.5
      }
    },
    working_sound =
    {
      sound = { filename = "__base__/sound/roboport-working.ogg", volume = 0.4 },
      max_sounds_per_type = 3,
      audible_distance_modifier = 0.75,
      --probability = 1 / (5 * 60) -- average pause between the sound is 5 seconds
    },
    recharging_light = {intensity = 0.2, size = 3, color = {r = 0.5, g = 0.5, b = 1.0}},
    request_to_open_door_timeout = 15,
    spawn_and_station_height = -0.1,

    draw_logistic_radius_visualization = true,
    draw_construction_radius_visualization = true,


    circuit_wire_connection_point = circuit_connector_definitions["roboport"].points,
    circuit_connector_sprites = circuit_connector_definitions["roboport"].sprites,
    circuit_wire_max_distance = default_circuit_wire_max_distance,

    default_available_logistic_output_signal = {type = "virtual", name = "signal-X"},
    default_total_logistic_output_signal = {type = "virtual", name = "signal-Y"},
    default_available_construction_output_signal = {type = "virtual", name = "signal-Z"},
    default_total_construction_output_signal = {type = "virtual", name = "signal-T"},

    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/roboport/roboport-reflection.png",
        priority = "extra-high",
        width = 28,
        height = 28,
        shift = util.by_pixel(0, 75),
        variation_count = 1,
        scale = 5
      },
      rotate = false,
      orientation_to_variation = false
    }
  },

  {
    type = "roboport",
    name = "construct-node",
    icon = "__base__/graphics/icons/roboport.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 0.1, result = "construct-node"},
    max_health = 500,
    corpse = "roboport-remnants",
    dying_explosion = "roboport-explosion",
    collision_box = {{-0.7, -0.7}, {0.7, 0.7}},
    selection_box = {{-1, -1}, {1, 1}},
    damaged_trigger_effect = {
      entity_name = "spark-explosion",
      offset_deviation = {{-0.5,-0.5},{0.5,0.5}},
      offsets = {{0,1}},
      type = "create-entity"
    },
    resistances =
    {
      {
        type = "fire",
        percent = 60
      },
      {
        type = "impact",
        percent = 30
      }
    },
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      input_flow_limit = "5MW",
      buffer_capacity = "100MJ"
    },
    recharge_minimum = "40MJ",
    energy_usage = "10kW",
    -- per one charge slot
    charging_energy = "1000kW",
    logistics_radius = 0,
    logistics_connection_distance = 1,
    construction_radius = 32,
    charge_approach_distance = 5,
    robot_slots_count = 0,
    material_slots_count = 0,
    stationing_offset = {0, 0},
    charging_offsets =
    {
      {-1.5, -0.5}, {1.5, -0.5}, {1.5, 1.5}, {-1.5, 1.5}
    },
    base =
    {
      layers =
      {
        {
          filename = modName .. "/graphic/Nodes/base.png",
          width = 1000,
          height = 1000,
          scale = 0.12,
          hr_version =
          {
            filename = modName .. "/graphic/Nodes/base.png",
            width = 1000,
            height = 1000,
            scale = 0.12
          }
        },
        {
          filename = modName .. "/graphic/Nodes/Network/node-shadow.png",
          width = 352,
          height = 352,
          draw_as_shadow = true,
          scale = 0.5,
          hr_version =
          {
            filename = modName .. "/graphic/Nodes/Network/node-shadow.png",
            width = 352,
            height = 352,
            draw_as_shadow = true,
            force_hr_shadow = true,
            scale = 0.5
          }
        }
      }
    },
    base_patch = blank_image,
    base_animation = blank_image,
    door_animation_up = blank_image,
    door_animation_down = blank_image,
    recharging_animation = blank_image,
    vehicle_impact_sound = {
      {
        filename = "__base__/sound/car-metal-impact.ogg",
        volume = 0.5
      },
      {
        filename = "__base__/sound/car-metal-impact-2.ogg",
        volume = 0.5
      },
      {
        filename = "__base__/sound/car-metal-impact-3.ogg",
        volume = 0.5
      },
      {
        filename = "__base__/sound/car-metal-impact-4.ogg",
        volume = 0.5
      },
      {
        filename = "__base__/sound/car-metal-impact-5.ogg",
        volume = 0.5
      },
      {
        filename = "__base__/sound/car-metal-impact-6.ogg",
        volume = 0.5
      }
    },
    working_sound =
    {
      sound = { filename = "__base__/sound/roboport-working.ogg", volume = 0.4 },
      max_sounds_per_type = 3,
      audible_distance_modifier = 0.75,
      --probability = 1 / (5 * 60) -- average pause between the sound is 5 seconds
    },
    recharging_light = {intensity = 0.2, size = 3, color = {r = 0.5, g = 0.5, b = 1.0}},
    request_to_open_door_timeout = 15,
    spawn_and_station_height = -0.1,

    draw_logistic_radius_visualization = true,
    draw_construction_radius_visualization = true,

    circuit_wire_connection_point = circuit_connector_definitions["roboport"].points,
    circuit_connector_sprites = circuit_connector_definitions["roboport"].sprites,
    circuit_wire_max_distance = default_circuit_wire_max_distance,

    default_available_logistic_output_signal = {type = "virtual", name = "signal-X"},
    default_total_logistic_output_signal = {type = "virtual", name = "signal-Y"},
    default_available_construction_output_signal = {type = "virtual", name = "signal-Z"},
    default_total_construction_output_signal = {type = "virtual", name = "signal-T"},

    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/roboport/roboport-reflection.png",
        priority = "extra-high",
        width = 28,
        height = 28,
        shift = util.by_pixel(0, 75),
        variation_count = 1,
        scale = 5
      },
      rotate = false,
      orientation_to_variation = false
    }
  },

  {
    type = "roboport",
    name = "bot-node",
    icon = "__base__/graphics/icons/roboport.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 0.1, result = "bot-node"},
    max_health = 500,
    corpse = "roboport-remnants",
    dying_explosion = "roboport-explosion",
    collision_box = {{-0.7, -0.7}, {0.7, 0.7}},
    selection_box = {{-1, -1}, {1, 1}},
    damaged_trigger_effect = {
      entity_name = "spark-explosion",
      offset_deviation = {{-0.5,-0.5},{0.5,0.5}},
      offsets = {{0,1}},
      type = "create-entity"
    },
    resistances =
    {
      {
        type = "fire",
        percent = 60
      },
      {
        type = "impact",
        percent = 30
      }
    },
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      input_flow_limit = "10MW",
      buffer_capacity = "100MJ"
    },
    recharge_minimum = "40MJ",
    energy_usage = "100kW",
    -- per one charge slot
    charging_energy = "10MW",
    logistics_radius = 0,
    logistics_connection_distance = 1,
    construction_radius = 0,
    charge_approach_distance = 5,
    robot_slots_count = 10,
    material_slots_count = 2,
    stationing_offset = {0, 0},
    charging_offsets =
    {
      {-1.5, -0.5}, {1.5, -0.5}, {1.5, 1.5}, {-1.5, 1.5}
    },
    base =
    {
      layers =
      {
        {
          filename = modName .. "/graphic/Nodes/base.png",
          width = 1000,
          height = 1000,
          scale = 0.12,
          hr_version =
          {
            filename = modName .. "/graphic/Nodes/base.png",
            width = 1000,
            height = 1000,
            scale = 0.12
          }
        },
        {
          filename = modName .. "/graphic/Nodes/Network/node-shadow.png",
          width = 352,
          height = 352,
          draw_as_shadow = true,
          scale = 0.5,
          hr_version =
          {
            filename = modName .. "/graphic/Nodes/Network/node-shadow.png",
            width = 352,
            height = 352,
            draw_as_shadow = true,
            force_hr_shadow = true,
            scale = 0.5
          }
        }
      }
    },
    base_patch = blank_image,
    base_animation = blank_image,
    door_animation_up = blank_image,
    door_animation_down = blank_image,
    recharging_animation = blank_image,
    vehicle_impact_sound = {
      {
        filename = "__base__/sound/car-metal-impact.ogg",
        volume = 0.5
      },
      {
        filename = "__base__/sound/car-metal-impact-2.ogg",
        volume = 0.5
      },
      {
        filename = "__base__/sound/car-metal-impact-3.ogg",
        volume = 0.5
      },
      {
        filename = "__base__/sound/car-metal-impact-4.ogg",
        volume = 0.5
      },
      {
        filename = "__base__/sound/car-metal-impact-5.ogg",
        volume = 0.5
      },
      {
        filename = "__base__/sound/car-metal-impact-6.ogg",
        volume = 0.5
      }
    },
    working_sound =
    {
      sound = { filename = "__base__/sound/roboport-working.ogg", volume = 0.4 },
      max_sounds_per_type = 3,
      audible_distance_modifier = 0.75,
      --probability = 1 / (5 * 60) -- average pause between the sound is 5 seconds
    },
    recharging_light = {intensity = 0.2, size = 3, color = {r = 0.5, g = 0.5, b = 1.0}},
    request_to_open_door_timeout = 15,
    spawn_and_station_height = -0.1,

    draw_logistic_radius_visualization = true,
    draw_construction_radius_visualization = true,

    circuit_wire_connection_point = circuit_connector_definitions["roboport"].points,
    circuit_connector_sprites = circuit_connector_definitions["roboport"].sprites,
    circuit_wire_max_distance = default_circuit_wire_max_distance,

    default_available_logistic_output_signal = {type = "virtual", name = "signal-X"},
    default_total_logistic_output_signal = {type = "virtual", name = "signal-Y"},
    default_available_construction_output_signal = {type = "virtual", name = "signal-Z"},
    default_total_construction_output_signal = {type = "virtual", name = "signal-T"},

    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/roboport/roboport-reflection.png",
        priority = "extra-high",
        width = 28,
        height = 28,
        shift = util.by_pixel(0, 75),
        variation_count = 1,
        scale = 5
      },
      rotate = false,
      orientation_to_variation = false
    }
  },
})