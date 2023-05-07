local utils = require "utils"

local function main()
    local loaderUI = utils.setupUI("Rednick16", "Extra Settings for Terraria", "Please no more terraria")
    
    local section = utils.addSection(loaderUI, "God hacks", "Turn them off")

    utils.addSwitch(section, "OkSwitch", "Godmode", 1, "Turn this on you won't die")
    
    utils.addTextField(section, "textValKey", "TextField", "", "", "placeholder")
    
    utils.addSlider(section, "testSlider", "Slider S", 40, "", -100, 100)
    
    utils.addPickerView(section, "pickerViewKey", "picker view", "", 0, {"Man", "Woman", "Dog", "Children"})
    
    
    local section2 = utils.addSection(loaderUI, "Section 2", "")
    utils.addPickerView(section2, "pickerViewKey", "picker view", "", 0, {"Test", "Ok", "No", "Idiot", "okay bob"})
    
    print(getValueForKey("OkSwitch"))
    
    -- Creating a navagtion switch(Not ready yet :(
    local navItem = utils.addNavigationSwitch(section, "navKey_827", "Nav Switch", "Takes you to a new page.")
    --local navSection = utils.addSection(navItem, "God hacks", "Turn them off")
    --utils.addSwitch(navItem, "ND", "No Drown", 1, "Turn this on you won't drown")

    -- Don't touch this.
    au.addSection(loaderUI)
end

main()
