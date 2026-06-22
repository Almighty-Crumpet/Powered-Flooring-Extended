-- control.lua
-- Space Age Compatible: Tracks entities per surface, handles multi-planet safely, 
-- cleans up on surface deletion, and throttles solar generation.

local SOLAR_TICK_INTERVAL = 60 -- 1Hz update for solar generation
local SOLAR_BASE_OUTPUT = 50000 -- 50kW per tile at full sun

-- Fast position key for dictionary storage
local function pos_key(x, y) return x .. "," .. y end

function Set (list)
	local set = {}
	for _, l in ipairs(list) do 
		set[l] = true 
	end
	return set
  end

function contains(list, x)
	for _, v in pairs(list) do
		if v == x 
		then 
			return true 
		end
	end
	return false
end

local tileNames = Set {
	"powered-floor-tile",
	"circuit-floor-tile",
	"solar-floor-tile",
	"logistics-floor-tile"
}

widgetEntities = function ()
	return 
	{
	"powered-floor-widget",
	"circuit-floor-widget",
	"solar-floor-widget",
	"logistics-floor-widget"
	}
end

-- List of specific entities allowed to connect
local connectableEntities = {
    ["small-electric-pole"] = true,
    ["medium-electric-pole"] = true,
    ["big-electric-pole"] = true,
    ["substation"] = true,
    ["powered-floor-widget"] = true
}

-- Safe wire connector lookup wrapper
local function get_wire_connector(entity, wire_type_id)
    if not entity or not entity.valid then return nil end
    local success, connector = pcall(entity.get_wire_connector, wire_type_id)
    if success and connector then
        return connector
    end
    return nil
end

-- Establish red and green wire connections
function IncludeControlWires(entity_a, entity_b)
    if not entity_a or not entity_b or not entity_a.valid or not entity_b.valid then return end

    -- Connect Red
    local red_a = get_wire_connector(entity_a, defines.wire_connector_id.circuit_red)
    local red_b = get_wire_connector(entity_b, defines.wire_connector_id.circuit_red)
    if red_a and red_b then red_a.connect_to(red_b) end

    -- Connect Green
    local green_a = get_wire_connector(entity_a, defines.wire_connector_id.circuit_green)
    local green_b = get_wire_connector(entity_b, defines.wire_connector_id.circuit_green)
    if green_a and green_b then green_a.connect_to(green_b) end
end

-- Network logic scoped to the targeted tiles
function IncludeControlWiresToNeighbors(source_entity, surface)
    if not source_entity or not source_entity.valid then return end
    if not connectableEntities[source_entity.name] then return end
    game.print("IncludeControlWiresToNeighbors passed start checks")

    local pos = source_entity.position
    local target_widget = nil

    -- If the source itself is the widget, use it directly. Otherwise, find it.
    if source_entity.name == "powered-floor-widget" then
        target_widget = source_entity
    else
        -- A pole was placed, so find the circuit widget sharing this exact tile space
        local widgets = surface.find_entities_filtered{
            name = "powered-floor-widget",
            position = pos
        }
        target_widget = widgets[1] -- Grab the first matched widget entity found
    end

    if not target_widget or not target_widget.valid then return end
    game.print("IncludeControlWiresToNeighbors passed final checks")

    -- Scan a tight 1.5 tile radius for neighbors
    local elist = surface.find_entities_filtered{
        area = {{pos.x - 1.5, pos.y - 1.5}, {pos.x + 1.5, pos.y + 1.5}}
    }

    for _, other_entity in ipairs(elist) do
        if other_entity.valid and other_entity ~= target_widget and connectableEntities[other_entity.name] then
            game.print("Found connectable entity: " .. other_entity.name .. " at position: " .. other_entity.position.x .. "," .. other_entity.position.y)
            -- Enforce strict tile adjacency constraints
            local other_pos = other_entity.position
            local dx = math.abs(pos.x - other_pos.x)
            local dy = math.abs(pos.y - other_pos.y)
            
            if dx <= 1.5 and dy <= 1.5 then
                IncludeControlWires(target_widget, other_entity)
            end
        end
    end
end

-- Initialize global storage when the game starts
script.on_init(function()
    if not storage.floor_entities then
        storage.floor_entities = {}
    end
end)

-- Initialize global storage when loading a save file (handles old saves without the key)
script.on_load(function()
    
end)

-- Helper functions
local function create_floor_entity(surface, pos, entity_name)
    local tile_x = math.floor(pos.x)
    local tile_y = math.floor(pos.y)
    local centered_pos = {x = tile_x + 0.5, y = tile_y + 0.5}
    --game.print("Creating entity " .. entity_name .. " at position: " .. centered_pos.x .. ", " .. centered_pos.y)
    local created_entity = surface.create_entity({
        name = entity_name,
        position = centered_pos,
        force = "neutral",
        build_effect = false
    })

    if created_entity and created_entity.valid then
        -- Safe lazy initialization setup right at the moment of creation
        if not storage.floor_entities then storage.floor_entities = {} end
        if not storage.floor_entities[surface.index] then
            storage.floor_entities[surface.index] = {}
        end
        
        local key = pos_key(tile_x, tile_y)
        if not storage.floor_entities[surface.index][key] then
            storage.floor_entities[surface.index][key] = {}
        end
        
        table.insert(storage.floor_entities[surface.index][key], created_entity)
    end
end

local function remove_floor_entity(surface, pos)
    local surf_idx = surface.index
    if not storage.floor_entities or not storage.floor_entities[surf_idx] then game.print("Floor entities not initialized for this surface.") return end

    -- Use integer tile coordinates to match the key used in create_floor_entity
    local tile_x = math.floor(pos.x)
    local tile_y = math.floor(pos.y)
    local key = pos_key(tile_x, tile_y)
    --game.print("Removing entities at tile: " .. tile_x .. "," .. tile_y)
    local entity_bucket = storage.floor_entities[surf_idx][key]

    if entity_bucket then
        for _, ent in pairs(entity_bucket) do
            if ent and ent.valid then
                ent.destroy()
            end
        end
    end
    
    storage.floor_entities[surf_idx][key] = nil

    if next(storage.floor_entities[surf_idx]) == nil then
        storage.floor_entities[surf_idx] = nil
    end
end

local function HandleTileBuild(tiles, surface)
    for _, oldTile in ipairs(tiles) do
        local pos = oldTile.position
        remove_floor_entity(surface, pos)

        local currentTile = surface.get_tile(pos.x, pos.y)
        
        -- 1. Fast O(1) Check: Immediately skip if the newly placed tile isn't one of ours
        if currentTile and tileNames[currentTile.name] then
            -- Every custom mod tile gets the basic power floor widget, it handles the copper cable connections itself
            local widget = create_floor_entity(surface, pos, "powered-floor-widget")
            -- 2. Add extra specialized widgets depending on the specific tile type
            if currentTile.name == "circuit-floor-tile" then
                -- Needs to connect the red/green circuits to adjacent 'powered-floor-widget' tile nodes
                IncludeControlWiresToNeighbors(widget, surface)
            elseif currentTile.name == "solar-floor-tile" then
                create_floor_entity(surface, pos, "solar-floor-widget")
            elseif currentTile.name == "logistics-floor-tile" then
                create_floor_entity(surface, pos, "logistics-floor-widget")
                -- Needs to also connect the red/green circuits to adjacent 'powered-floor-widget' tile nodes
                IncludeControlWiresToNeighbors(widget, surface)
            end
        end
    end
end

-- Events
-- BuiltEvent (Player, Robot, and Sandbox-safe)
local function BuiltEvent(event)
    local surface = game.get_surface(event.surface_index)
    if not surface then return end

    local tiles = event.tiles
    if not tiles then return end

    HandleTileBuild(tiles, surface)
end

local function MinedEvent(event)
    local surface = game.get_surface(event.surface_index)
    if not surface then game.print("Surface not found.") return end
    
    local tiles = event.tiles
    if not tiles then 
        game.print("MinedEvent triggered but no tiles data found.")
        return 
    end
    
    local count = 0
    for _, tile_data in pairs(tiles) do
        if tile_data and tile_data.position then
            count = count + 1
            game.print("Mined tile at: " .. tile_data.position.x .. "," .. tile_data.position.y)
            remove_floor_entity(surface, tile_data.position)
        end
    end
    
    --game.print("MinedEvent processed " .. count .. " tiles.")
end

local function OnEntityBuilt(event)
    local entity = event.entity or event.destination
    if not entity or not entity.valid then return end
    
    -- If it's a connectable pole, automatically look for a floor widget underneath it
    if connectableEntities[entity.name] and entity.name ~= "powered-floor-widget" then
        local surface = entity.surface
        IncludeControlWiresToNeighbors(entity, surface)
    end
end

script.on_event({
    defines.events.on_player_built_tile,
    defines.events.on_robot_built_tile,
    defines.events.script_raised_set_tiles
}, function(e)
    BuiltEvent(e)
end)

script.on_event({
    defines.events.on_player_mined_tile,
    defines.events.on_robot_mined_tile
}, function(e)
    MinedEvent(e)
end)

script.on_event({
    defines.events.on_player_built_entity,
    defines.events.on_robot_built_entity,
    defines.events.script_raised_built,
    defines.events.script_raised_revive
}, OnEntityBuilt)

script.on_event({defines.events.on_tiles_seted}, function(event)
    local surface = game.get_surface(event.surface_index)
    -- FIX: Use storage instead of global
    if not surface or not storage.floor_entities then return end

    for _, tile_data in pairs(event.tiles) do
        if tileNames[tile_data.old_tile.name] then
            remove_floor_entity(surface, tile_data.position)
        end
    end
end)

-- Clean up on surface deletion
script.on_event(defines.events.on_surface_deleted, function(event)
    -- FIX: Use storage instead of global
    if storage.floor_entities then
        storage.floor_entities[event.surface_index] = nil
    end
end)