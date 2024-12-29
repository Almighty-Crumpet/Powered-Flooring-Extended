local modName = "__PoweredFloorExtended__"
local tile_collision_masks = require("__base__/prototypes/tile/tile-collision-masks")

data:extend({
-- Hidden Widgets
{
    type = "item",
    name = "powered-floor-widget",
    icon = modName .. "/graphic/powered-floor-icon.png",
    icon_size = 32,
    hidden = true,
    subgroup = "energy-pipe-distribution",
    order = "a[energy]-p4[medium-electric-pole]",
    place_result = "powered-floor-widget",
    stack_size = 500
},

{
    type = "item",
    name = "circuit-floor-widget",
    icon = modName .. "/graphic/powered-floor-icon.png",
    icon_size = 32,
    hidden = true,
    subgroup = "energy-pipe-distribution",
    order = "a[energy]-p5[medium-electric-pole]",
    place_result = "circuit-floor-widget",
    stack_size = 500
},

{
    type = "item",
    name = "solar-floor-widget",
    icon = modName .. "/graphic/Flooring/" .. settings.startup["solar-flooring-style"].value .. "/icon/tile.png",
    icon_size = 32,
    hidden = true,
    subgroup = "energy-pipe-distribution",
    order = "a[energy]-p4[medium-electric-pole]",
    place_result = "solar-floor-widget",
    stack_size = 500
},

{
    type = "item",
    name = "logistics-floor-widget",
    icon = modName .. "/graphic/Flooring/" .. settings.startup["network-flooring-style"].value .. "/icon/tile.png",
    icon_size = 32,
    hidden = true,
    subgroup = "logistic-network",
    order = "c[signal]-b[logistics-floor-widget]",
    place_result = "logistics-floor-widget",
    stack_size = 500
},
-- Flooring
{
    type = "item",
    name = "powered-floor-tile",
    icon = modName .. "/graphic/Flooring/" .. settings.startup["powered-flooring-style"].value .. "/icon/tile.png",
    icon_size = 32,
    subgroup = "terrain",
    order = "c[powered]-a[powered-floor-tile]",
    stack_size = 1000,
    place_as_tile =
    {
        result = "powered-floor-tile",
        condition_size = 1,
        condition = {layers={water_tile=true}}
    }
},

{
    type = "item",
    name = "circuit-floor-tile",
    icon = modName .. "/graphic/Flooring/" .. settings.startup["circuit-flooring-style"].value .. "/icon/tile.png",
    icon_size = 32,
    subgroup = "terrain",
    order = "c[powered]-b[circuit-floor-tile]",
    stack_size = 1000,
    place_as_tile =
    {
        result = "circuit-floor-tile",
        condition_size = 1,
        condition = {layers={water_tile=true}}
    }
},

{
    type = "item",
    name = "solar-floor-tile",
    icon = modName .. "/graphic/Flooring/" .. settings.startup["solar-flooring-style"].value .. "/icon/tile.png",
    icon_size = 32,
    subgroup = "terrain",
    order = "c[powered]-c[solar-floor-tile]",
    stack_size = 1000,
    place_as_tile =
    {
        result = "solar-floor-tile",
        condition_size = 1,
        condition = {layers={water_tile=true}}
    }
},

{
    type = "item",
    name = "logistics-floor-tile",
    icon = modName .. "/graphic/Flooring/" .. settings.startup["network-flooring-style"].value .. "/icon/tile.png",
    icon_size = 32,
    subgroup = "terrain",
    order = "c[powered]-d[logistic-floor-tile]",
    stack_size = 1000,
    place_as_tile =
    {
        result = "logistics-floor-tile",
        condition_size = 1,
        condition = {layers={water_tile=true}}
    }
},
-- Nodes
{
    type = "item",
    name = "network-node",
    icon = modName .. "/graphic/Nodes/Network/icon/node.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "logistic-network",
    order = "c[signal]-b[network-node]",
    place_result = "network-node",
    stack_size = 50
},
{
    type = "item",
    name = "construct-node",
    icon = modName .. "/graphic/Nodes/Construct/icon/node.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "logistic-network",
    order = "c[signal]-c[construct-node]",
    place_result = "construct-node",
    stack_size = 50
},
{
    type = "item",
    name = "bot-node",
    icon = modName .. "/graphic/Nodes/Bot/icon/node.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "logistic-network",
    order = "c[signal]-d[bot-node]",
    place_result = "bot-node",
    stack_size = 50
},

})
