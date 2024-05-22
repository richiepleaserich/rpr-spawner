local QBCore = exports['qb-core']:GetCoreObject()




local CreatePed = function(modelHash, coords, scenario)
    local created_npc = CreatePed(5, modelHash, coords.x, coords.y, coords.z, true, true)
    SetEntityHeading(created_npc, heading)
    FreezeEntityPosition(created_npc, true)
    SetEntityInvincible(created_npc, true)
    SetBlockingOfNonTemporaryEvents(created_npc, true)
    TaskStartScenarioInPlace(created_npc, scenario, 0, true)

end

local CreateProp = function(modelHash, coords)
    local created_prop = CreateObject(modelHash, coords.x, coords.y, coords.z, true, true, false)
    SetEntityHeading(created_prop, coords.w)
    FreezeEntityPosition(created_prop, true)
    SetEntityInvincible(created_prop, true)
end

local SpawnEntities = function()
    CreateThread(function()
        -- Spawn NPCs
        for _, npc in pairs(Config.NPCs) do
            local npcModel = GetHashKey(npc.modelHash)
            RequestModel(npcModel)
            while not HasModelLoaded(npcModel) do
                Wait(1)
            end
            CreatePed(npcModel, npc.coords, npc.scenario)
        end

        -- Spawn Props
        for _, prop in pairs(Config.Props) do
            local propModel = GetHashKey(prop.modelHash)
            RequestModel(propModel)
            while not HasModelLoaded(propModel) do
                Wait(1)
            end
            CreateProp(propModel, prop.coords)
        end
    end)
end

CreateThread(function()
    SpawnEntities()
end)