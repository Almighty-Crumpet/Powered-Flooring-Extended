local modName = "__PoweredFloorExtended__"
local selectedStyle = settings.startup["flooring-style"].value

data:extend({
{
	type = "technology",
	name = "powered-floors",
	icon = modName .. "/graphic/Technology/powered-floor-technology-icon.png",
	icon_size = 128,
	effects =
	{
		{
			type = "unlock-recipe",
			recipe = "powered-floor-tile"
		},
		{
			type = "unlock-recipe",
			recipe = "powered-floor-circuit-tile"
		}
	},
	prerequisites = {"automation-3"},
	unit =
		{
			count = 150,
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"production-science-pack", 1}
			},
			time = 60
		},
	order = "c-k-a",
},
{
	type = "technology",
	name = "powered-floors-solar",
	icon = modName .. "/graphic/Technology/powered-floor-technology-icon.png",
	icon_size = 128,
	effects =
	{
		{
			type = "unlock-recipe",
			recipe = "solar-powered-floor-tile"
		}
	},
	prerequisites = {"space-science-pack"},
	unit =
		{
			count = 10,
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"space-science-pack", 1}
			},
			time = 10
		},
	order = "c-k-a",
},
})
