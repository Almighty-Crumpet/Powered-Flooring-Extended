function Set (list)
	local set = {}
	for _, l in ipairs(list) do 
		set[l] = true 
	end
	return set
  end

local tileNames = Set {
	"powered-floor-tile",
	"circuit-floor-tile",
	"solar-floor-tile",
	"logistics-floor-tile"
}

local connectableEntities = Set {
	"small-electric-pole",
	"medium-electric-pole",
	"big-electric-pole",
	"substation",
	"circuit-floor-widget"
}

function contains(list, x)
	for _, v in pairs(list) do
		if v == x 
		then 
			return true 
		end
	end
	return false
end

-- Event Handler for on_built_entity and on_robot_built_entity
function BuiltEntity(event)
    local pf_entity = event.entity
	--debug_print("BuiltEntity " .. event.created_entity.name)
	--if (contains(connectableEntities, event.created_entity.name))
	if connectableEntities[pf_entity.name]
    then    
        local surface = pf_entity.surface
        IncludeControlWiresToNeighbors( pf_entity, surface )
    end
end


-- Event Handler for on_player_built_tile
--
-- Add the widget
function PlayerBuiltTile(event)
    --debug_print("PlayerBuiltTile")
    local player = game.players[event.player_index]
    if player ~= nil and event.tiles ~= nil and player.surface ~= nil
    then
    	IncludePoweredWidget(event.tiles, player.surface )
    elseif player == nil
    then
    	game.print("PlayerBuiltTile nil player?")
    elseif event.tiles == nil
    then
    	game.print("PlayerBuiltTile nil positions?")
    elseif player.surface == nil
    then
    	game.print("PlayerBuiltTile nil surface?")
    end
    
end

-- Event Handler for on_robot_built_tile
--
-- Add the widget
function RobotBuiltTile(event)
    --debug_print("RobotBuiltTile")
    if(event.robot ~= nil)
    then
    	--debug_print("RobotBuiltTile event.robot not nil")
    	if(event.robot.surface ~= nil)
    	then
    	--	debug_print("RobotBuiltTile event.robot.surface not nil")
    	else
    	--	debug_print("RobotBuiltTile event.robot.surface is nil")
    	end
    else
    	--debug_print("RobotBuiltTile event.robot is nil")
    end
    if(event.robot ~= nil and event.robot.surface ~= nil)
    then 
       IncludePoweredWidget(event.tiles, event.robot.surface)
    end

end

-- returns whether some_entity should be connected with a control wire
function EntityConnectable(some_entity)
	return connectableEntities[some_entity.name]
end


-- connect red and green wires from a powered floor tap or widget to another entity if appropriate
function IncludeControlWires(pf_entity, some_entity)

    --debug_print("IncludeControlWires some_entity.name=" .. some_entity.name)
    
    connectable = EntityConnectable(some_entity)
    if connectable
    then
        --debug_print("IncludeControlWires connecting neighbor with control wires " 
        -- 	.. pf_entity.position.x .. "," .. pf_entity.position.y .. " to "
        --	.. some_entity.position.x .. "," .. some_entity.position.y  )
        	
		-- Grab the wire connector of the target
		targetRedConnector = some_entity.get_wire_connector(defines.wire_connector_id.circuit_red ,true)
		targetGreenConnector = some_entity.get_wire_connector(defines.wire_connector_id.circuit_green ,true)
		-- Grab the wire connector of the current entity
		entityRedConnectors = pf_entity.get_wire_connector(defines.wire_connector_id.circuit_red ,true)
		entityGreenConnectors = pf_entity.get_wire_connector(defines.wire_connector_id.circuit_green ,true)
		-- Connect both the red and green wires

		entityRedConnectors.connect_to(targetRedConnector)
		entityGreenConnectors.connect_to(targetGreenConnector)

    else
    	--debug_print("IncludeControlWires not connectable")
    end
end

-- for all neighboring entities, connect control wires (if appropriate)
function IncludeControlWiresToNeighbors(pf_entity, surface)
	local X = pf_entity.position.x 
	local Y = pf_entity.position.y  
	--debug_print("IncludeControlWiresToNeighbors looking around " .. X .. "," .. Y)
	elist = surface.find_entities_filtered{ area={{X-1.5, Y-1.5}, {X+1.5, Y+1.5}} }
	
	for i, other_entity in ipairs(elist)
	do
		--debug_print("IncludeControlWiresToNeighbors found entity " .. other_entity.name .. " type " .. other_entity.type .. " at " .. other_entity.position.x .. "," .. other_entity.position.y)

		if( other_entity.position.x == X and other_entity.position.y == Y  )
		then
		--	debug_print("IncludeControlWiresToNeighbors that's me")
		else
		--	debug_print("IncludeControlWiresToNeighbors found entity at " .. other_entity.position.x .. "," .. other_entity.position.y)
			IncludeControlWires(pf_entity,other_entity )
		end
	end
end

-- when adding tiles, include a hidden widget which has power wires
-- if it's a circuit tile, add the circuit wires too
function IncludePoweredWidget(tiles, surface)
	--debug_print("IncludePoweredWidget")


	for i, oldtile in ipairs(tiles)
	do
		local position = oldtile.position
		--debug_print("IncludePoweredWidget x " .. position.x .. " y " .. position.y )
		local currentTile = surface.get_tile(position.x,position.y)

		local currentTilename = surface.get_tile(position.x,position.y).name

		local X = position.x
		local Y = position.y

		--debug_print("IncludePowered tilename is " .. currentTilename .. " at " .. X .. "," .. Y)

		if (tileNames[currentTilename])
		then
			if (currentTilename == "logistics-floor-tile")
			then
				createPoweredEntity(surface, "logistics-floor-widget", X, Y)
				createPoweredEntity(surface, "circuit-floor-widget", X, Y)
				IncludeControlWiresToNeighbors( pf_entity, surface )
			elseif (currentTilename == "circuit-floor-tile")
			then
				createPoweredEntity(surface, "circuit-floor-widget", X, Y)
				IncludeControlWiresToNeighbors( pf_entity, surface )
			elseif (currentTilename == "solar-floor-tile")
			then
				createPoweredEntity(surface, "solar-floor-widget", X, Y)
				createPoweredEntity(surface, "powered-floor-widget", X, Y)
			else
				createPoweredEntity(surface, "powered-floor-widget", X, Y)
			end
		end
	end
end

function createPoweredEntity(surface, widgetName, X, Y)
	pf_entity = surface.create_entity{name = widgetName, position = {X,Y}, force = game.forces.player}
	pf_entity.destructible = false
	pf_entity.update_connections()
end

script.on_event(defines.events.on_player_built_tile,	PlayerBuiltTile)
script.on_event(defines.events.on_robot_built_tile, 	RobotBuiltTile)
script.on_event({
	defines.events.on_built_entity,
	defines.events.on_robot_built_entity,
    defines.events.script_raised_built,
    defines.events.script_raised_revive,
	}, function(e) 
	BuiltEntity(e)
end)