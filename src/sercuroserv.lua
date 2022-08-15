isHack = false

local progress = 0
local soundId = -1
local blip = {0, 0}

local isOutOfRange = true

-- Entity, Time per % (in ms), Radius, Colour Blip, extraBlip, Sprite
local hack = {0, 10, 10, "eventName", true}

local function SetPercentage()
    BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(27)
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamInt(1)
    ScaleformMovieMethodAddParamInt(progress)
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
    ScaleformMovieMethodAddParamInt(27) 
    ScaleformMovieMethodAddParamInt(0) 
    EndScaleformMovieMethod()
end

local function SetNoSignal(bool)
    if bool then 
        BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
        ScaleformMovieMethodAddParamInt(27)
        ScaleformMovieMethodAddParamInt(0)
        ScaleformMovieMethodAddParamInt(0)
        ScaleformMovieMethodAddParamInt(progress)
        EndScaleformMovieMethod()
        
        BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
        ScaleformMovieMethodAddParamInt(27) 
        ScaleformMovieMethodAddParamInt(0) 
        EndScaleformMovieMethod()
    else
        BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
        ScaleformMovieMethodAddParamInt(27)
        ScaleformMovieMethodAddParamInt(0)
        ScaleformMovieMethodAddParamInt(1)
        ScaleformMovieMethodAddParamInt(progress)
        EndScaleformMovieMethod()
        
        BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
        ScaleformMovieMethodAddParamInt(27) 
        ScaleformMovieMethodAddParamInt(0) 
        EndScaleformMovieMethod()
    end
end

local function StartTimer()
    CreateThread(function()
        while isHack and progress < 100 do 
            Wait(10)
            
            if phoneActive and appList == 1 then      
                if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(hack[1])) < hack[3] and isOutOfRange then 
                    PlaySoundFrontend(-1, "Hack_Start", "dlc_xm_deluxos_hacking_Hacking_Sounds", true)
                    PlaySoundFrontend(soundId, "Hack_Loop", "dlc_xm_deluxos_hacking_Hacking_Sounds", true)
                    SetNoSignal(false)
                    isOutOfRange = false
                elseif #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(hack[1])) >= hack[3] and not isOutOfRange then
                    StopSound(soundId)
                    SetNoSignal(true)
                    isOutOfRange = true
                end
            else 
                Wait(100)
            end
        end
    end)
    
    CreateThread(function()
        while isHack and progress < 100 do 
            Wait(hack[2])
            if phoneActive and appList == 1 then 
                if not isOutOfRange then 
                    progress = progress + 1
                    SetPercentage()
                    if progress == 100 then
                        StopSound(soundId)
                        PlaySoundFrontend(-1, "Hack_Complete", "dlc_xm_deluxos_hacking_Hacking_Sounds", true) 
                        for i = 1, #blip do 
                            RemoveBlip(blip[i])
                        end
                        progress = 0
                        appList = 0
                        isHack = false 
                        headers[9] = "SecuroServ"
                        DeleteEntity(hack[1])
                        SetPlacement(1, 0)
                        if hack[5] then 
                            TriggerServerEvent(hack[4])
                        else
                            TriggerEvent(hack[4])
                        end
                    end
                end
            else
                Wait(100)
            end            
        end
    end)
end

local function CreateHackArea()
    CreateThread(function()
        while progress < 100 do 
            Wait(0)
            SetBlipCoords(blip[1], GetEntityCoords(hack[1]))
        end
    end)
end

local function SetupHack(entity, interval, radius, colour, extraBlip, sprite, eventName, isServer)    
    hack = {entity, interval, radius, eventName, isServer}

    blip[1] = AddBlipForRadius(GetEntityCoords(entity), radius)
    SetBlipAlpha(blip[1], 175)

    if extraBlip then
        blip[2] = AddBlipForEntity(entity)
        SetBlipSprite(blip[2], sprite)
    end   

    for i = 1, #blip do 
        SetBlipColour(blip[i], colour)
    end

    CreateHackArea()
    
    headers[9] = "SecuroServ Hack"
    isHack = true

    if soundId == -1 then 
        soundId = GetSoundId()
    end

    StartTimer()
end

function OpenSecuroServHack()
    BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
    ScaleformMovieMethodAddParamInt(27) 
    ScaleformMovieMethodAddParamInt(0) 
    EndScaleformMovieMethod()
end

RegisterNetEvent("cl:ifruit:setSecuroServ", SetupHack)