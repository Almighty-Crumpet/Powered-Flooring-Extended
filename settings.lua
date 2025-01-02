local mod_name = "__PoweredFloorExtended__"
local styles = function() return {"Default","Tile-White","Tile-Blue","Tile-Red","Solar-Blue","Hex-Blue","Hex-White","Hex-Red","Alt-Grey"} end
local solarStyles = function() return {"Default","Solar-Blue","Hex-Blue"} end


data:extend{
    {
        type = "string-setting",
        name = "powered-flooring-style",
        setting_type = "startup",
        default_value = "Alt-Grey",
        allowed_values = styles(),
    },
    {
        type = "string-setting",
        name = "circuit-flooring-style",
        setting_type = "startup",
        default_value = "Hex-Red",
        allowed_values = styles(),
    },
    {
        type = "string-setting",
        name = "solar-flooring-style",
        setting_type = "startup",
        default_value = "Solar-Blue",
        allowed_values = styles(),
    },
    {
        type = "string-setting",
        name = "network-flooring-style",
        setting_type = "startup",
        default_value = "Default",
        allowed_values = styles(),
    },
    {
        type = "string-setting",
        name = "enable-circuit-flooring",
        setting_type = "startup",
        default_value = "No",
        allowed_values = {"Yes","No"},
    }
}