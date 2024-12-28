local mod_name = "__PoweredFloorExtended__"
local styles = function() return {"Default"} end

data:extend{
    {
        type = "string-setting",
        name = "flooring-style",
        setting_type = "startup",
        default_value = "Default",
        allowed_values = styles(),
    }
}