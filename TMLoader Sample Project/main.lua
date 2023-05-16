local utils = require "utils"
local mod = require "Mod"
local array = require "IL2CppArray"

local spawn = true

function Update()
    --local localPlayer = mod.Invoke(null, "Terraria.Main::get_LocalPlayer()", {})
    local localPlayer = mod.get_LocalPlayer()
    if localPlayer ~= null then

        if isSwitchOn("buffImuneKey") then 
            local buffImmune = mod.GetMemberValue(localPlayer, "buffImmune")
            if buffImmune ~= null then
                local length = array.GetLength(buffImmune)
                for i = 0, length - 1 do
                    local value = array.GetValueAtIndex(buffImmune, i)
                    if value ~= null then
                        --local actualValue = au.read("bool", value)
                        --print(actualValue)

                        -- Immune to all buffs or debuffs lol
                        au.write("bool", value, true)
                    end
                end
            end
        end
        
        if isSwitchOn("ghostAllKey") then 
            local players = mod.GetMemberValue(null, "Terraria.Main.player")
            if players ~= null then
                for i = 0, array.GetLength(players) - 1 do
                    local value = array.GetValueAtIndex(players, i)
                    if value ~= null then
                        local player = au.read("void*", value)
                        if player ~= localPlayer then
                            -- turn everyone into a ghost lol
                            mod.SetMemberValue(player, "ghost", true)
                        end
                    end
                end
            end
        end

        if isSwitchOn("autoJumpKey") then 
            mod.SetMemberValue(localPlayer, "autoJump", true)
        end

        if isSwitchOn("noFallDmgKey") then 
            mod.SetMemberValue(localPlayer, "noFallDmg", true)
        end
        
        if isSwitchOn("InfiniteFlightKey") then 
            mod.SetMemberValue(localPlayer, "wingTime", 999999)
            mod.SetMemberValue(localPlayer, "wingTimeMax", 999999)
        end

        if isSwitchOn("ghostModeKey") then 
            mod.SetMemberValue(localPlayer, "ghost", true)
        else
            mod.SetMemberValue(localPlayer, "ghost", false)
        end

        if isSwitchOn("godmodeKey") then 
            local statLifeMax = mod.GetMemberValue(localPlayer, "statLifeMax")
            mod.SetMemberValue(localPlayer, "statLife", statLifeMax)

            local statManaMax = mod.GetMemberValue(localPlayer, "statManaMax")
            mod.SetMemberValue(localPlayer, "statMana", statManaMax)
        end

        
        local itemID = getValueForKey("spawnItemTextFieldKey")
        local itemAmount = getValueForKey("itemAmountTextFieldKey")
        --print("ID: ", itemID, " amount: ", type(tonumber(itemAmount)))

        if isSwitchOn("spawnItemKey") then 
            if spawn then
                mod.Invoke(localPlayer, "QuickSpawnItem(IEntitySource, int, int)", { null, mod.ItemType(itemID),  tonumber(itemAmount)})
                spawn = false
            end
        else
            spawn = true
        end
    end
end

-- This is my Free craft mod for terraria xd Its incomplete i need to fix a few things.
function freeCraft()
    local recipes = mod.GetMemberValue(null, "Terraria.Main.recipe")
    if recipes ~= null then
        for i = 0, array.GetLength(recipes) - 1 do
            local recipe_element = array.GetValueAtIndex(recipes, i)
            if recipe_element ~= null then
                local recipe = au.read("void*", recipe_element)
                if recipe ~= null then
                    local requiredItems = mod.GetMemberValue(recipe, "requiredItem")
                    for ri = 0, array.GetLength(requiredItems) - 1 do
                        local requiredItem_element = array.GetValueAtIndex(requiredItems, ri)
                        if requiredItem_element ~= null then
                            local requiredItem = au.read("void*", requiredItem_element)
                            if requiredItem ~= null then
                                mod.SetMemberValue(requiredItem, "type", mod.ItemType(""))
                                mod.SetMemberValue(requiredItem, "stack", 0)
                            end
                        end
                    end

                    -- I am having issues with this part i am still fixing it.
                    local requiredItemQuickLookups = mod.GetMemberValue(recipe, "requiredItemQuickLookup")
                    if requiredItemQuickLookups ~= null then
                        for ji = 0, array.GetLength(requiredItemQuickLookups) - 1 do
                            local requiredItemQuickLookup_element = array.GetValueAtIndex(requiredItemQuickLookups, ji)
                            if requiredItemQuickLookup_element ~= null then
                                local requiredItemQuickLookup = au.read("void*", requiredItemQuickLookup_element)
                                if requiredItemQuickLookup ~= null then
                                    mod.SetMemberValue(requiredItemQuickLookup, "itemIdOrRecipeGroup", mod.ItemType(""))
                                    mod.SetMemberValue(requiredItemQuickLookup, "stack", 0)
                                end
                            end
                        end
                    end

                    local requiredTiles = mod.GetMemberValue(recipe, "requiredTile")
                    if requiredTiles ~= null then
                        for j = 0, array.GetLength(requiredTiles) - 1 do
                            local required_element = array.GetValueAtIndex(requiredTiles, j)
                            if required_element ~= null then
                                au.write("int", required_element, -1)
                            end
                        end
                    end

                    mod.SetMemberValue(recipe, "needHoney", false)
                    mod.SetMemberValue(recipe, "needWater", false)
                    mod.SetMemberValue(recipe, "needLava", false)

                    mod.SetMemberValue(recipe, "needSnowBiome", false)
                    mod.SetMemberValue(recipe, "needGraveyardBiome", false)
                    mod.SetMemberValue(recipe, "needEverythingSeed", false)
                end
            end
        end
    end
end

local function setup(mainView)
    local section = utils.addSection(mainView, "Basics", "")
    utils.addSwitch(section, "godmodeKey", "Godmode", 0, "")
    utils.addSwitch(section, "InfiniteFlightKey", "Infinite Flight", 0, "")
    utils.addSwitch(section, "ghostModeKey", "Ghost Mode", 0, "")
    utils.addSwitch(section, "noFallDmgKey", "No Fall Damage", 0, "")
    utils.addSwitch(section, "autoJumpKey", "Auto Jump", 0, "")

    local testSection = utils.addSection(mainView, "Just some tests :)", "")
    utils.addSwitch(testSection, "ghostAllKey", "Ghost Everyone", 0, "")
    utils.addSwitch(testSection, "buffImuneKey", "Immune to All Buffs", 0, "")

    local itemSpawnerSection = utils.addSection(mainView, "Item Spanwer", "Enter an item then hit Spawn Item")
    utils.addSwitch(itemSpawnerSection, "spawnItemKey", "Spawn Item", 0, "")
    utils.addTextField(itemSpawnerSection, "spawnItemTextFieldKey", "Item ID", "", "", "(Terra Blade)")
    utils.addTextField(itemSpawnerSection, "itemAmountTextFieldKey", "Item Amount", "", "", "(amount)")
end

local function main()
    local loaderUI, mainView = utils.setupUI("Rednick16", "Extra Settings for Terraria", "Please no more terraria")
    setup(mainView)

    -- Don't touch this.
    au.addSection(loaderUI)
end

main()
