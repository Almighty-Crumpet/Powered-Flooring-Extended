local mod_name = "__PoweredFloorExtended__"
local styles = function() return {"Default","Tile-White","Tile-Blue","Tile-Red","Hex-White","Hex-Blue","Hex-Red","Triangle-Grey"} end

data:extend{
    {
        type = "string-setting",
        name = "powered-flooring-style",
        setting_type = "startup",
        default_value = "Tile-White",
        allowed_values = styles(),
    },
    {
        type = "string-setting",
        name = "circuit-flooring-style",
        setting_type = "startup",
        default_value = "Hex-White",
        allowed_values = styles(),
    },
    {
        type = "string-setting",
        name = "solar-flooring-style",
        setting_type = "startup",
        default_value = "Hex-Blue",
        allowed_values = styles(),
    },
    {
        type = "string-setting",
        name = "network-flooring-style",
        setting_type = "startup",
        default_value = "Triangle-Grey",
        allowed_values = styles(),
    }
}