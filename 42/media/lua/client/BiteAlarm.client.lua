local PHRASES_LOWEST = {
    getText("IGUI_Alarm_Lowest_1"),
    getText("IGUI_Alarm_Lowest_2"),
    getText("IGUI_Alarm_Lowest_3"),
    getText("IGUI_Alarm_Lowest_4")
}

local PHRASES_LOW = {
    getText("IGUI_Alarm_Low_1"),
    getText("IGUI_Alarm_Low_2"),
    getText("IGUI_Alarm_Low_3"),
    getText("IGUI_Alarm_Low_4"),
    getText("IGUI_Alarm_Low_5")
}

local PHRASES_MEDIUM = {
    getText("IGUI_Alarm_Medium_1"),
    getText("IGUI_Alarm_Medium_2"),
    getText("IGUI_Alarm_Medium_3")
}

local PHRASES_HIGH = {
    getText("IGUI_Alarm_High_1"),
    getText("IGUI_Alarm_High_2"),
    getText("IGUI_Alarm_High_3"),
    getText("IGUI_Alarm_High_4")
}

local PHRASES_HIGHEST = {
    getText("IGUI_Alarm_Highest_1"),
    getText("IGUI_Alarm_Highest_2"),
    getText("IGUI_Alarm_Highest_3"),
    getText("IGUI_Alarm_Highest_4"),
    getText("IGUI_Alarm_Highest_5")
}

local function getRandomPhrase(list)
    local randomNumber = ZombRand(#list)+1
    return list[randomNumber]
end

local function checkForPlayerInfection()
    local player = getSpecificPlayer(0)
    local bodyDamage = player:getBodyDamage()
    local infectionLevel = bodyDamage:getInfectionLevel()
    local isInfected = bodyDamage:isInfected()

    if isInfected then
        local chance = ZombRand(1) -- 50% chance
        if chance == 0 then 
            if infectionLevel >= 90 then -- fever
                player:Say(getRandomPhrase(PHRASES_HIGHEST))
            elseif infectionLevel >= 75 then -- sick
                player:Say(getRandomPhrase(PHRASES_HIGH))
            elseif infectionLevel >= 50 then -- nauseous
                player:Say(getRandomPhrase(PHRASES_MEDIUM))
            elseif infectionLevel >= 25 then -- queasy
                player:Say(getRandomPhrase(PHRASES_LOW))
            elseif infectionLevel >= 1 then -- half an hour in game delay
                player:Say(getRandomPhrase(PHRASES_LOWEST))            
            end
        end
    end
end

Events.OnGameStart.Add(function()
    print('------- INITIALISING BITE ALARM ------')
    -- Events.EveryOneMinute.Add(checkForPlayerInfection)
    -- Events.EveryTenMinutes.Add(checkForPlayerInfection)
    Events.EveryHours.Add(checkForPlayerInfection)
end)