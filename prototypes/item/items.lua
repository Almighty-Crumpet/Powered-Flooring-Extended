local modName = "__PoweredFloorExtended__"
local selectedStyle = settings.startup["flooring-style"].value

data:extend({
{
    type = "item",
    name = "powered-floor-widget",
    icon = modName .. "/graphic/powered-floor-icon.png",
    icon_size = 32,
    flags = {"hidden"},
    subgroup = "energy-pipe-distribution",
    order = "a[energy]-p4[medium-electric-pole]",
    place_result = "powered-floor-widget",
    stack_size = 500
},

{
    type = "item",
    name = "powered-floor-circuit-widget",
    icon = modName .. "/graphic/powered-floor-icon.png",
    icon_size = 32,
    flags = {"hidden"},
    subgroup = "energy-pipe-distribution",
    order = "a[energy]-p5[medium-electric-pole]",
    place_result = "powered-floor-circuit-widget",
    stack_size = 500
},

{
    type = "item",
    name = "powered-floor-tap",
    icon = modName .. "/graphic/powered-floor-tap.png",
    icon_size = 32,
    subgroup = "energy-pipe-distribution",
    order = "a[energy]-p3[powered-floor-tap]",
    place_result = "powered-floor-tap",
    stack_size = 500
},

{
    type = "item",
    name = "solar-floor-widget",
    icon = modName .. "/graphic/powered-floor-tap.png",
    icon_size = 32,
    flags = {"hidden"},
    subgroup = "energy-pipe-distribution",
    order = "a[energy]-p4[medium-electric-pole]",
    place_result = "solar-floor-widget",
    stack_size = 500
},

{
    type = "item",
    name = "powered-floor-tile",
    icon = modName .. "/graphic/powered-floor-icon.png",
    icon_size = 32,
    subgroup = "energy-pipe-distribution",
    order = "a[energy]-p1[powered-floor-tile]",
    stack_size = 1000,
    place_as_tile =
    {
    result = "powered-floor-tile",
    condition_size = 3,
    condition = { "water-tile" }
    }
},

{
    type = "item",
    name = "powered-floor-circuit-tile",
    icon = modName .. "/graphic/powered-floor-circuit-icon.png",
    icon_size = 32,
    subgroup = "energy-pipe-distribution",
    order = "a[energy]-p2[powered-floor-circuit-tile]",
    stack_size = 1000,
    place_as_tile =
    {
    result = "powered-floor-circuit-tile",
    condition_size = 3,
    condition = { "water-tile" }
    }
},

{
    type = "item",
    name = "solar-powered-floor-tile",
    icon = modName .. "/graphic/slow-powered-floor-icon.png",
    icon_size = 32,
    subgroup = "energy-pipe-distribution",
    order = "a[energy]-p3[solar-floor-tile]",
    stack_size = 1000,
    place_as_tile =
    {
    result = "solar-powered-floor-tile",
    condition_size = 3,
    condition = { "water-tile" }
    }
},

})
