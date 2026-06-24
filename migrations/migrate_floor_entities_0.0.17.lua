-- migrations/migrate_floor_entities.lua
-- Crawls all surfaces to find existing untracked widgets and index them safely into storage

if not storage.floor_entities then
    storage.floor_entities = {}
end

-- Recreate helper locally for migration runtime environment security
local function pos_key(x, y) return x .. "," .. y end

-- Scan every surface (safe for Space Age planets and custom surfaces)
for _, surface in pairs(game.surfaces) do
    local surf_idx = surface.index
    storage.floor_entities[surf_idx] = storage.floor_entities[surf_idx] or {}

    -- Find all legacy hidden floor widgets currently alive on this surface
    local widgets = surface.find_entities_filtered{
        name = {
            "powered-floor-widget",
            "circuit-floor-widget",
            "solar-floor-widget",
            "logistics-floor-widget"
        }
    }

    for _, widget in ipairs(widgets) do
        if widget.valid then
            local pos = widget.position
            local tile_x = math.floor(pos.x)
            local tile_y = math.floor(pos.y)
            local key = pos_key(tile_x, tile_y)

            -- Ensure the coordinate bucket table exists in storage
            storage.floor_entities[surf_idx][key] = storage.floor_entities[surf_idx][key] or {}

            -- Check if this specific entity instance is already tracked to avoid double-indexing
            local already_tracked = false
            for _, tracked_ent in ipairs(storage.floor_entities[surf_idx][key]) do
                if tracked_ent == widget then
                    already_tracked = true
                    break
                end
            end

            -- Track it! Now the new version's remove_floor_entity() can find and destroy it smoothly
            if not already_tracked then
                table.insert(storage.floor_entities[surf_idx][key], widget)
            end
        end
    end
end