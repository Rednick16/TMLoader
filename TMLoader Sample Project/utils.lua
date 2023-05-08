au = require "aurora"

local utils = {}

function isSwitchOn(key)
    return au.defaultsValueForKey(key) == 1
end

function getValueForKey(key)
    return au.defaultsValueForKey(key)
end

--[[
Usage:
local row, component = getPickerViewSelection("someKey")
print("Selected row:", row)
print("Selected component:", component)
--]]
function getPickerViewSelection(key)
    local selectedRow = getValueForKey(key).selectedRow
    local selectedComponent = getValueForKey(key).selectedComponent
    return selectedRow, selectedComponent
end

function utils.setupUI(author, title, description)
    local section = {
        Title = "Author: " .. author,
        Description = "",
        Items = {
            {
                Type = "PreferencesListController",
                Key = "kPLC:" .. author,
                Title = title,
                Description = description,
                AccessoryType = 1,
                SelectionStyle = 1,
                Sections = { }
            }
        }
    }
    return section, section.Items[1]
end

function utils.addSection(view, title, description)
    local section = {
        Title = title,
        Description = description,
        Items = { }
    }
    table.insert(view.Sections, section)
    return section
end

function utils.addSwitch(section, key, title, defaultValue, description)
    local item = {
        Type = "Switch",
        Key = key,
        Title = title,
        DefaultValue = defaultValue,
        Description = description
    }
    table.insert(section.Items, item)
end

function utils.addTextField(section, key, title, defaultValue, description, placeholder)
    local item = {
        Type = "TextField",
        Key = key,
        Title = title,
        DefaultValue = defaultValue,
        Description = description,
        Placeholder = placeholder,
        IsSecure = 0,
        ClearButtonMode = 0
    }
    table.insert(section.Items, item)
end

function utils.addSlider(section, key, title, defaultValue, description, minimumValue, maximumValue)
    local item = {
        Type = "Slider",
        Key = key,
        Title = title,
        DefaultValue = defaultValue,
        Description = description,
        MinimumValue = minimumValue,
        MaximumValue = maximumValue,
        SliderWidth = 200
    }
    table.insert(section.Items, item)
end

function utils.addPickerView(section, key, title, description, defaultValue, items)
    local item = {
        Type = "PickerView",
        Key = key,
        Title = title,
        DefaultValue = defaultValue,
        Description = description,
        Items = items,
        Cell = {
            CellStyle = 0,
            CellHeight = 100
            --CellBackgroundColor = "#eb4034",
            --TextLabelTextColor = "rgb(200, 100, 10)",
            --DetailTextLabelTextColor = "rgb(20, 255, 60)"
        }
    }
    table.insert(section.Items, item)
end

function utils.addNavigationSwitch(section, key, title, description)
    local navItem = {
        Type = "PreferencesListController",
        Key = key,
        Title = title,
        Description = description,
        AccessoryType = 1,
        SelectionStyle = 1,
        Sections = { }
    }
    table.insert(section.Items, navItem)
    return navItem
end

return utils