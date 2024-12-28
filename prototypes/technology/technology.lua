local modName = "__PoweredFloorExtended__"
local selectedStyle = settings.startup["flooring-style"].value

data:extend({
{
	type = "technology",
	name = "powered-floors-lv1",
	icon = modName .. "/graphic/powered-floor-technology-icon.png",
	icon_size = 128,
	effects =
	{
		{
			type = "unlock-recipe",
			recipe = "powered-floor-tap"
		},
		{
			type = "unlock-recipe",
			recipe = "powered-floor-circuit-tile"
		},
		{
			type = "unlock-recipe",
			recipe = "powered-floor-tile"
		},
		{
			type = "unlock-recipe",
			recipe = "solar-powered-floor-tile"
		}
	},
	prerequisites = {"automation"},
	unit =
		{
			count = 10,
			ingredients =
			{
				{"automation-science-pack", 1}
			},
			time = 10
		},
	order = "c-k-a",
},
})
