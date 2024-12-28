for index, force in pairs(game.forces) do
	local technologies = force.technologies
	local recipes = force.recipes

	if (settings.startup["enable-circuit-flooring"].value)
	then
		recipes["circuit-floor-tile"].enabled = technologies["powered-floors"].researched
	else
		recipes["circuit-floor-tile"].enabled = false;
	end
end

local function swap_entities(surface, tiles)
	local position, newEntity, widget, force
	
	for t, tile in pairs(tiles) do
		position = tile.position
	  
		-- check the same x/y coordinates for the existing entity on the tile
		Widgets = surface.find_entities_filtered{name = "powered-floor-widget", position = position, radius = 1}
		-- if it is only a 'power-floor-widget' then remove it and add a 'circuit-floor-widget' in it's place
		if next(Widgets) then
			for w, widget in pairs(Widgets) do
				if widget then
					-- Store force and delete widget
					force = widget.force
					widget.destroy{raise_destroy = true}

					-- Add new widget
					newEntity = surface.create_entity{
						name = 'circuit-floor-widget',
						position = {position.x, position.y},
						force = force,
						raise_built = true,
					}

					IncludeControlWiresToNeighbors(newEntity, surface)
					if newEntity then
						newEntity.destructible = false
					end
				end
			end
		end
	end
end

-- get surface tiles
local oldSurfaceTiles, newSurfaceTiles
for s, surface in pairs(game.surfaces) do
  -- Always look for the old tiles
  oldSurfaceTiles = surface.find_tiles_filtered{name = "logistics-powered-floor-tile"}
  -- Will only exist if oldSurfaceTiles is an empty table
  newSurfaceTiles = not next(oldSurfaceTiles) and
                    surface.find_tiles_filtered{name = 'logistics-floor-tile'}
  
  -- loop through and for each tile that is a logistics floor tile
  if newSurfaceTiles and next(newSurfaceTiles) then
    swap_entities(surface, newSurfaceTiles)
  elseif next(oldSurfaceTiles) then
    swap_entities(surface, oldSurfaceTiles)
  end
end

