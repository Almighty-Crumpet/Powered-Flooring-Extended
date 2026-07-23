-- control.lua
-- Space Age Compatible: Tracks entities per surface, handles multi-planet safely,
-- cleans up on surface deletion

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
        if v == x then
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
    ["powered-floor-widget"] = true, -- Universal master widget
    ["circuit-floor-widget"] = true  -- Retained to support legacy poles/tiles in existing saves
}
-- Generates an array of names: {"small-electric-pole", "medium-electric-pole", etc.}
local connectableEntityNames = {}
for name, _ in pairs(connectableEntities) do table.insert(connectableEntityNames, name) end

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
    --game.print("IncludeControlWires called for entities: " .. entity_a.name .. " and " .. entity_b.name)
    if not entity_a or not entity_b or not entity_a.valid or not entity_b.valid then 
        game.print("One or both entities are invalid.")
        return 
    end
    -- Factorio 1.1 / 2.0 Electric Poles use a single 'pole_circuit' ID for all circuit wires
    local connector_id = defines.wire_connector_id.pole_circuit
    -- Connect Red
    local red_a = entity_a.get_wire_connector(defines.wire_connector_id.circuit_red, true)
    local red_b = entity_b.get_wire_connector(defines.wire_connector_id.circuit_red, true)
    --game.print("Red connectors: " .. (red_a and "found" or "not found") .. ", " .. (red_b and "found" or "not found"))
    if red_a and red_b then 
        -- In Factorio 2.0, you can pass false as the second argument to bypass engine wire length checks
        red_a.connect_to(red_b) 
        --game.print("Red wire connection established between " .. entity_a.name .. " and " .. entity_b.name)
    end
    -- Connect Green
    local green_a = entity_a.get_wire_connector(defines.wire_connector_id.circuit_green, true)
    local green_b = entity_b.get_wire_connector(defines.wire_connector_id.circuit_green, true)
    --game.print("Green connectors: " .. (green_a and "found" or "not found") .. ", " .. (green_b and "found" or "not found"))
    if green_a and green_b then 
        -- Specify the wire type as green to prevent it from overlaying as a red wire
        green_a.connect_to(green_b)
        --game.print("Green wire connection established between " .. entity_a.name .. " and " .. entity_b.name)
    end
end

function IncludeControlWiresToNeighbors(source_entity, surface)
    if not source_entity or not source_entity.valid then return end
    if not connectableEntities[source_entity.name] then return end

    local pos = source_entity.position
    local is_floor_widget = (source_entity.name == "powered-floor-widget" or source_entity.name == "circuit-floor-widget")

    local elist = {}
    if is_floor_widget then
        -- Rule A: A tile widget was built.
        -- 1. Grab neighboring floor-widgets within 1.5 tile radius
        local widgets = surface.find_entities_filtered{
            area = {{pos.x - 1.5, pos.y - 1.5}, {pos.x + 1.5, pos.y + 1.5}},
            name = {"powered-floor-widget", "circuit-floor-widget"} -- Only find other widgets out wide
        }
        
        -- 2. Tight search: Grab allowed poles/widgets directly on top of this tile
        local structures = surface.find_entities_filtered{
            area = {{pos.x - 0.5, pos.y - 0.5}, {pos.x + 0.5, pos.y + 0.5}},
            name = connectableEntityNames -- Engine-level filter strictly using your list
        }
        
        -- Merge the lists safely
        elist = widgets
        for _, struct in ipairs(structures) do
            table.insert(elist, struct)
        end
    else
        -- Rule B: A pole/structure was built.
        -- Tight search: Only find allowed things directly on top of its own coordinate
        elist = surface.find_entities_filtered{
            area = {{pos.x - 0.5, pos.y - 0.5}, {pos.x + 0.5, pos.y + 0.5}},
            name = connectableEntityNames -- Engine-level filter strictly using your list
        }
    end

    -- Process the filtered list
    for _, other_entity in pairs(elist) do
        if other_entity.valid and other_entity ~= source_entity then
            
            local proceed_with_connection = true
            local other_is_floor_widget = (other_entity.name == "powered-floor-widget" or other_entity.name == "circuit-floor-widget")

            -- Rule C: Skip connection if a 2x2 entity is already connected to a widget
            if not is_floor_widget and not other_is_floor_widget then
                local size = source_entity.prototype.tile_size or 1
                if size == 2 then
                    local connector = source_entity.get_wire_connector(defines.wire_connector_id.circuit_red, true) 
                                   or source_entity.get_wire_connector(defines.wire_connector_id.circuit_green, true)
                    
                    if connector and connector.connections then
                        for _, connection in pairs(connector.connections) do
                            local target = connection.target.owner
                            if target.valid and (target.name == "powered-floor-widget" or target.name == "circuit-floor-widget") then
                                proceed_with_connection = false
                                break
                            end
                        end
                    end
                end
            end

            if proceed_with_connection then
                if is_floor_widget and other_is_floor_widget then
                    -- Math check ONLY applied to widget-to-widget connections
                    local dx = pos.x - other_entity.position.x
                    local dy = pos.y - other_entity.position.y
                    local distance = math.sqrt((dx * dx) + (dy * dy))

                    if distance <= 1.6 then
                        IncludeControlWires(source_entity, other_entity)
                    end
                else
                    -- Tight placement matches connect directly without distance checks
                    IncludeControlWires(source_entity, other_entity)
                end
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

-- Initialize global storage when loading a save file
script.on_load(function()
    -- Global initialization if required
end)

-- Helper functions
local function create_floor_entity(surface, pos, entity_name, event_force)
    local tile_x = math.floor(pos.x)
    local tile_y = math.floor(pos.y)
    local centered_pos = {x = tile_x + 0.5, y = tile_y + 0.5}

    local created_entity = surface.create_entity{
        name = entity_name,
        position = centered_pos,
        force = event_force or "player",
        build_effect = false,
        raise_built = true 
    }

    if created_entity and created_entity.valid then
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
    return created_entity
end

local function remove_floor_entity(surface, pos)
    local surf_idx = surface.index
    if not storage.floor_entities or not storage.floor_entities[surf_idx] then game.print("Floor entities not initialized for this surface.") return end

    local tile_x = math.floor(pos.x)
    local tile_y = math.floor(pos.y)
    local key = pos_key(tile_x, tile_y)

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

local function HandleTileBuild(tiles, surface, force)
    for _, oldTile in ipairs(tiles) do
        local pos = oldTile.position
        
        -- Clean up existing widgets at this spot (Clears out hidden items for Landfill, Waterfill, Vanilla, and Modded tiles)
        remove_floor_entity(surface, pos)

        local currentTile = surface.get_tile(pos.x, pos.y)

        -- Fast O(1) Check: Re-spawn widgets ONLY if it matches our tiles
        if currentTile and tileNames[currentTile.name] then
            -- Every custom mod tile gets the basic power floor widget
            local master_widget = create_floor_entity(surface, pos, "powered-floor-widget", force)

            -- Add extra specialized widgets depending on the specific tile type
            if currentTile.name == "circuit-floor-tile" then
                -- Circuit tiles utilize the universal widget directly
                IncludeControlWiresToNeighbors(master_widget, surface)

            elseif currentTile.name == "solar-floor-tile" then
                create_floor_entity(surface, pos, "solar-floor-widget", force)

            elseif currentTile.name == "logistics-floor-tile" then
                create_floor_entity(surface, pos, "logistics-floor-widget", force)
                -- Logistics tiles loop into your red/green wire network
                IncludeControlWiresToNeighbors(master_widget, surface)
            end
        end
    end
end

-- Events
-- BuiltEvent (Player, Robot, and Sandbox safe)
local function BuiltEvent(event)
    local surface = game.get_surface(event.surface_index)
    if not surface then return end

    local tiles = event.tiles
    if not tiles then return end

    HandleTileBuild(tiles, surface, event.force)
end

local function MinedEvent(event)
    local surface = game.get_surface(event.surface_index)
    if not surface then game.print("Surface not found.") return end

    local tiles = event.tiles
    if not tiles then game.print("MinedEvent triggered but no tiles data found.") return end

    for _, tile_data in pairs(tiles) do
        remove_floor_entity(surface, tile_data.position)
    end
end

local function OnEntityBuilt(event)
    local entity = event.entity or event.destination
    if not entity or not entity.valid then 
        game.print("OnEntityBuilt triggered but no valid entity found.") 
        return 
    end

    -- Check if it's a connectable pole placed over our flooring setup
    --game.print("OnEntityBuilt triggered for entity: " .. entity.name .. " at position: " .. entity.position.x .. "," .. entity.position.y)
    if connectableEntities[entity.name] and entity.name ~= "powered-floor-widget" and entity.name ~= "circuit-floor-widget" then
        local surface = entity.surface
        IncludeControlWiresToNeighbors(entity, surface)
    end
end

-- Event Registry Array Mapping
script.on_event({
    defines.events.on_player_built_tile,
    defines.events.on_robot_built_tile,
    defines.events.script_raised_set_tiles
}, BuiltEvent)

script.on_event({
    defines.events.on_player_mined_tile,
    defines.events.on_robot_mined_tile
}, MinedEvent)

-- Combined event registry to catch normal play, bots, sandbox cheats, and script tools
script.on_event({
    defines.events.on_built_entity,           -- Sandbox cheats, Map Editor, instant placements
    defines.events.on_player_built_entity,    -- Normal player placement
    defines.events.on_robot_built_entity,     -- Construction robot placement
    defines.events.script_raised_built,       -- Fast script setups / Clone tools
    defines.events.script_raised_revive,      -- Blueprint script revivals
    defines.events.on_entity_cloned,          -- Map editor copying/pasting templates
    defines.events.on_space_platform_built_entity -- Factorio 2.0 Space Age orbital platforms
}, OnEntityBuilt)

script.on_event({defines.events.on_tiles_seted}, function(event)
    local surface = game.get_surface(event.surface_index)
    if not surface or not storage.floor_entities then return end

    for _, tile_data in pairs(event.tiles) do
        if tileNames[tile_data.old_tile.name] then
            remove_floor_entity(surface, tile_data.position)
        end
    end
end)

script.on_event({defines.events.on_surface_deleted}, function(event)
    if storage.floor_entities then
        storage.floor_entities[event.surface_index] = nil
    end
end)