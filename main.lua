local utils = require "utils"

local function main()
    local loaderUI, mainView = utils.setupUI("Rednick16", "Extra Settings for Terraria", "Please no more terraria")
    
    local section = utils.addSection(mainView, "God hacks", "Turn them off")

    utils.addSwitch(section, "OkSwitch", "Godmode", 1, "Turn this on you won't die")
    
    utils.addTextField(section, "textValKey", "TextField", "", "", "placeholder")
    
    utils.addSlider(section, "testSlider", "Slider S", 40, "", -100, 100)
    
    utils.addPickerView(section, "pickerViewKey",
    "picker view", "", 0, {
        {"Man", "Woman", "Dog", "Children"}
    })
    
    local section2 = utils.addSection(mainView, "Section 2", "")
    utils.addPickerView(section2, "pickerViewKey2",
    "picker view", "", 0, {
        {"Test", "Ok", "No", "Idiot", "okay bob"},
        {"Nop", "RET", "MOV X", "MOV W", "BL"}
    })
    
    local navItem = utils.addNavigationSwitch(section, "navKey_827", "Nav Switch", "Takes you to a new page.")
    local navSection = utils.addSection(navItem, "navItem section", "navItem description")
    utils.addSwitch(navSection, "ND", "No Drown", 1, "Turn this on you won't drown")

    -- Don't touch this.
    au.addSection(loaderUI)
end

main()
