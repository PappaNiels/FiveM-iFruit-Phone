scaleform = RequestScaleformMovie("CELLPHONE_IFRUIT")
altPlacement = 0
appList = 0
dataType = 0
currentTheme = GetResourceKvpInt("ifruit-phone:theme")
previousList = 0

phoneActive = false 

if currentTheme == 0 then 
    currentTheme = 1
end

currentBackground = GetResourceKvpInt("ifruit-phone:background")

if currentBackground == 0 then 
    currentBackground = 10
end

local sleepMode = false
local inApp = false 
local isPhoneRotated = false

local placement = 4 

local icons = {4, 2, 5, 14, 12, 24, 1, 6, 57}

local buttons = {
  {5, 1, 4}, -- Email
  {11, 2, 4}, -- Text
  {9, 5, 4}, -- Contacts
  {1, 2, 4}, -- Job list
  {1, 2, 4}, -- Home/Settings
  {12, 5, 4}, -- Inner Text / Email
  {1, 13, 4}, -- Inner Job list
  {1, 1, 4} -- Empty
}

local buttonColours = {
    {49, 160, 224},
    {116, 226, 133},
    {255, 0, 0}
}

local function LoadScaleform()
    while not HasScaleformMovieLoaded(scaleform) do 
        Wait(0)
    end
end

local function RotatePhone(toEmail)
    isPhoneRotated = toEmail
    if toEmail then 
        CreateThread(function()
            while GetMobilePhonePosition().x > 56 do 
                DisableAllControlActions(2)
                SetMobilePhonePosition(GetMobilePhonePosition().x - 1, -28.0, -60.0)
                Wait(2)
            end
            while GetMobilePhoneRotation().z < 89 do 
                DisableAllControlActions(2)
                SetMobilePhoneRotation(-90.0, 0.0, GetMobilePhoneRotation().z + 2)
                Wait(1)
            end
        end)
    else 
        CreateThread(function()
            while GetMobilePhonePosition().x < 61.5 do 
                DisableAllControlActions(2)
                SetMobilePhonePosition(GetMobilePhonePosition().x + 1, -28.0, -60.0)
                Wait(2)
            end
            while GetMobilePhoneRotation().z > 1 do 
                DisableAllControlActions(2)
                SetMobilePhoneRotation(-90.0, 0.0, GetMobilePhoneRotation().z - 2)
                Wait(1)
            end
        end)
    end
end

local function MovePhone(up)
    if up then 
        while GetMobilePhonePosition().y < -27 do 
            DisableAllControlActions(2)
            SetMobilePhonePosition(61.5, GetMobilePhonePosition().y + 4, -60.0)
            Wait(1)
        end
    else
        while GetMobilePhonePosition().y > -67 do 
            DisableAllControlActions(2)
            SetMobilePhonePosition(61.5, GetMobilePhonePosition().y - 4, -60.0)
            Wait(1)
        end
    end
end

local function GetDataLength()
    if dataType == 0 then -- Email
        return #emails
    elseif dataType == 1 then -- Text
        return #texts
    elseif dataType == 2 then -- Contacts
        return #contacts + #standardContacts
    elseif dataType == 4 then -- Job List
        return #jobListInv
    elseif dataType == 5 then -- Settings
        if appList == 1 then 
            return #settings
        elseif previousList == 0 then  
            return #background 
        else 
            return #theme
        end
    elseif dataType == 8 then -- SecuroServ
        return #securoservInv
    end
end

local function GetApp(app)
    if app == 0 then 
        return 8
    elseif app == 1 then 
        return 6
    elseif app == 2 then 
        return 2
    elseif app == 4 then 
        return 20
    elseif app == 5 then 
        return 22
    elseif app == 8 then 
        return 1 
    end
end

local function GetUnread(i)
    local num = 0
    if i == 0 then 
        for i = 1, #emails do 
            if not emails[i][4] then 
                num = num + 1
            end
        end
    elseif i == 1 then 
        for i = 1, #texts do 
            if not texts[i][7] then 
                num = num + 1
            end
        end
    elseif i == 4 then 
        for i = 1, #jobListInv do 
            if not jobListInv[i][8] then 
                num = num + 1
            end
        end
    end
    return num
end

local function SetButtons(num)
    for i = 1, 3 do
        BeginScaleformMovieMethod(scaleform, "SET_SOFT_KEYS")
        ScaleformMovieMethodAddParamInt(i)
        ScaleformMovieMethodAddParamInt(1)
        ScaleformMovieMethodAddParamInt(buttons[num][i])
        EndScaleformMovieMethod()

        BeginScaleformMovieMethod(scaleform, "SET_SOFT_KEYS_COLOUR") 
        ScaleformMovieMethodAddParamInt(i)
        ScaleformMovieMethodAddParamInt(buttonColours[i][1])
        ScaleformMovieMethodAddParamInt(buttonColours[i][2])
        ScaleformMovieMethodAddParamInt(buttonColours[i][3])
        EndScaleformMovieMethod()
    end
end

local function SetSleepMode(bool)
    sleepMode = bool

    BeginScaleformMovieMethod(scaleform, "SET_SLEEP_MODE")
    ScaleformMovieMethodAddParamBool(bool)
    EndScaleformMovieMethod()
end

local function SetTheme(_theme)
    currentTheme = _theme
    SetResourceKvpInt("ifruit-phone:theme", currentTheme)
    
    BeginScaleformMovieMethod(scaleform, "SET_THEME")
    ScaleformMovieMethodAddParamInt(theme[currentTheme][3])
    EndScaleformMovieMethod()
end

local function SetHeader(num)
    BeginScaleformMovieMethod(scaleform, "SET_HEADER")
    ScaleformMovieMethodAddParamPlayerNameString(headers[num])
    EndScaleformMovieMethod()
end

local function SetBackground(_background)
    currentBackground = _background 
    SetResourceKvpInt("ifruit-phone:background", currentBackground)

    BeginScaleformMovieMethod(scaleform, "SET_BACKGROUND_IMAGE")
    ScaleformMovieMethodAddParamInt(background[currentBackground][3])
    EndScaleformMovieMethod()
end

local function OpenQuick()
    InfoMsg(notAvailable)
end

local function OpenCamera()
    InfoMsg(notAvailable)
end

local function OpenInternet()
    InfoMsg(notAvailable)
end

local function SetAppsHome()
    for i = 0 , 9 do 
        BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
        ScaleformMovieMethodAddParamInt(1) -- Type 
        ScaleformMovieMethodAddParamInt(i) -- Place 
        ScaleformMovieMethodAddParamInt(icons[i + 1]) -- Icon
        if i == 0 or i == 1 or i == 4 then 
            ScaleformMovieMethodAddParamInt(GetUnread(i))
        end
        EndScaleformMovieMethod()
    end

    SetButtons(5)

    BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
    ScaleformMovieMethodAddParamInt(1) -- Type
    ScaleformMovieMethodAddParamInt(placement) -- Place
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(scaleform, "SET_HEADER")
    ScaleformMovieMethodAddParamPlayerNameString(headers[5])
    EndScaleformMovieMethod()
end

local function DisablePhone()
    DestroyMobilePhone()
    SetPauseMenuActive(true)
    phoneActive = false
    appList = 0
    altPlacement = 0 
    placement = 4
end

function SetUnread(i) 
    BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(1) -- Type 
    ScaleformMovieMethodAddParamInt(i) -- Place 
    ScaleformMovieMethodAddParamInt(icons[i + 1]) -- Icon
    if i == 0 or i == 1 or i == 4 then 
        ScaleformMovieMethodAddParamInt(GetUnread(i))
    end
    EndScaleformMovieMethod()
end

function SetPlacement(app, change)
    if app == 1 then 
        placement = placement + change

        BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
        ScaleformMovieMethodAddParamInt(1) -- Type
        ScaleformMovieMethodAddParamInt(placement) -- Place
        EndScaleformMovieMethod()

        BeginScaleformMovieMethod(scaleform, "SET_HEADER")
        ScaleformMovieMethodAddParamPlayerNameString(headers[placement + 1])
        EndScaleformMovieMethod()
    else 
        altPlacement = altPlacement + change 

        BeginScaleformMovieMethod(scaleform, "SET_INPUT_EVENT")
        if change > 0 then 
            ScaleformMovieMethodAddParamInt(3)
        else 
            ScaleformMovieMethodAddParamInt(1)
        end

        BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
        ScaleformMovieMethodAddParamInt(app) -- Type
        ScaleformMovieMethodAddParamInt(altPlacement) -- Place
        EndScaleformMovieMethod()
    end
end

-- Show Phone
CreateThread(function()
    while true do
        Wait(0)
        if phoneActive then            
            SetPauseMenuActive(false)
			SetTextRenderId(renderId)
			DrawScaleformMovie(scaleform, 0.0998, 0.1775, 0.1983, 0.364, 255, 255, 255, 255);
            SetTextRenderId(1)
        else 
            Wait(200)
        end
    end
end)

-- Key Presses
CreateThread(function()
    while true do 
        Wait(0)
        if not phoneActive then  
            if IsControlJustPressed(0, keyOpenPhone) then 
                LoadScaleform()
                PlaySoundFrontend(-1, "Pull_Out", "Phone_SoundSet_Michael", true)
                CreateMobilePhone(0)
                SetMobilePhoneScale(280.0)
                SetMobilePhoneRotation(-90.0, 0.0, 0.0)
                SetMobilePhonePosition(61.5, -68.0, -60.0)
                SetSleepMode(sleepMode)
                SetTheme(currentTheme)
                SetBackground(currentBackground)
                SetAppsHome()
                MovePhone(true)

                for i = 1, #standardContacts do 
                    LoadTexture(standardContacts[i][2])
                end

                phoneActive = true
            end
        else 
            Wait(1000)
        end
    end
end)

CreateThread(function()
    while true do
        Wait(0) 
        if phoneActive and appList == 0 then 
            if IsControlJustPressed(0, 172) then -- Up
                if placement ~= 0 and placement ~= 1 and placement ~= 2 then 
                    PlaySoundFrontend(-1, "Menu_Navigate", "Phone_SoundSet_Michael", true)
                    SetPlacement(1, -3)
                end
            elseif IsControlJustPressed(0, 173) then -- Down
                if placement ~= 6 and placement ~= 7 and placement ~= 8 then 
                    PlaySoundFrontend(-1, "Menu_Navigate", "Phone_SoundSet_Michael", true)
                    SetPlacement(1, 3)
                end
            elseif IsControlJustPressed(0, 174) then -- Left
                if placement ~= 0 and placement ~= 3 and placement ~= 6 then 
                    PlaySoundFrontend(-1, "Menu_Navigate", "Phone_SoundSet_Michael", true)
                    SetPlacement(1, -1)
                end
            elseif IsControlJustPressed(0, 175) then -- Right
                if placement ~= 2 and placement ~= 5 and placement ~= 8 then 
                    PlaySoundFrontend(-1, "Menu_Navigate", "Phone_SoundSet_Michael", true)
                    SetPlacement(1, 1)
                end                
            elseif IsControlJustPressed(0, 176) then -- Enter
                PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Michael", true)
                dataType = placement
                if placement == 0 then 
                    OpenEmail()
                    if #emails == 0 then 
                        SetButtons(8)
                    else
                        SetButtons(1)
                    end
                    RotatePhone(true)
                    appList = 1
                elseif placement == 1 then
                    OpenTexts()
                    if #texts == 0 then 
                        SetButtons(8)
                    else
                        SetButtons(2)
                    end
                    appList = 1
                elseif placement == 2 then
                    OpenContacts()
                    SetButtons(3)
                    appList = 1
                elseif placement == 3 then
                    OpenQuick()
                elseif placement == 4 then
                    OpenJobList()
                    if #jobListInv == 0 then 
                        SetButtons(8)
                    else
                        SetButtons(4)
                    end
                    appList = 1
                elseif placement == 5 then
                    OpenSettings()
                    appList = 1
                elseif placement == 6 then
                    OpenCamera()
                elseif placement == 7 then
                    OpenInternet()
                elseif placement == 8 then
                    if not isHack then 
                        --OpenSecuroServ()
                        InfoMsg(notAvailable)
                    else 
                        appList = 1
                        OpenSecuroServHack()
                    end
                end
            elseif IsControlJustPressed(0, 177) then -- Backspace
                PlaySoundFrontend(-1, "Menu_Back", "Phone_SoundSet_Michael", true)
                MovePhone(false)
                DisablePhone()
            end
        else 
            Wait(100)
        end
    end
end)

CreateThread(function()
    while true do 
        Wait(0)
        if appList == 1 then
            if IsControlJustPressed(0, 172) then -- Up
                if altPlacement ~= 0  then 
                    PlaySoundFrontend(-1, "Menu_Navigate", "Phone_SoundSet_Michael", true)
                    SetPlacement(GetApp(dataType), -1)
                end
            elseif IsControlJustPressed(0, 173) then -- Down                
                if altPlacement ~= GetDataLength() - 1 then 
                    PlaySoundFrontend(-1, "Menu_Navigate", "Phone_SoundSet_Michael", true)
                    SetPlacement(GetApp(dataType), 1)
                end
            elseif IsControlJustPressed(0, 177) then -- Backspace
                PlaySoundFrontend(-1, "Menu_Back", "Phone_SoundSet_Michael", true)
                SetPlacement(1, 0)
                if dataType == 0 then 
                    UnloadEmails()
                    RotatePhone(false)
                elseif dataType == 1 then 
                    UnloadTexts()
                elseif dataType == 2 then 
                    UnloadContacts()
                elseif dataType == 4 then 
                    UnloadJobList()
                elseif dataType == 5 then 
                    UnloadAllSettings()
                end
                SetButtons(5)
                appList = appList - 1
            elseif IsControlJustPressed(0, 176) then -- Enter
                PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Michael", true)
                previousList = altPlacement
                if dataType == 0 then 
                    OpenEmailText(altPlacement)
                    SetButtons(6)
                    appList = appList + 1
                elseif dataType == 1 then
                    OpenTextsText(altPlacement)
                    SetButtons(6)
                    appList = appList + 1
                elseif dataType == 2 then
                    --print(altPlacement) 
                    if standardContacts[altPlacement + 1][1] == bombContact then 
                        if eventBomb[2] then 
                            TriggerServerEvent(eventBomb[1])
                        else
                            TriggerEvent(eventBomb[1])
                        end
                        DisablePhone()
                    end
                    --Call(altPlacement) To Do
                    --appList = appList + 1
                elseif dataType == 3 then 
                    
                elseif dataType == 4 then 
                    OpenJobListInvite(altPlacement)
                    SetButtons(7)
                    appList = appList + 1
                elseif dataType == 5 then 
                    OpenSettingsType(altPlacement)
                elseif dataType == 6 then 
                    
                elseif dataType == 7 then 
                    
                elseif dataType == 8 then 
                    
                end
            end
        else 
            Wait(100)
        end
    end
end)

CreateThread(function()
    while true do 
        Wait(0)
        if appList == 2 then 
            if IsControlJustPressed(0, 172) then -- Up
                if altPlacement ~= 0  then 
                    PlaySoundFrontend(-1, "Menu_Navigate", "Phone_SoundSet_Michael", true)
                    SetPlacement(GetApp(dataType), -1)
                end
            elseif IsControlJustPressed(0, 173) then -- Down
                if altPlacement ~= GetDataLength() - 1 then 
                    PlaySoundFrontend(-1, "Menu_Navigate", "Phone_SoundSet_Michael", true)
                    SetPlacement(GetApp(dataType), 1)
                end
            elseif IsControlJustPressed(0, 177) then -- Backspace
                PlaySoundFrontend(-1, "Menu_Back", "Phone_SoundSet_Michael", true)
                SetPlacement(GetApp(dataType), 0)
                if dataType == 0 then 
                    UnloadFullEmails()
                    OpenEmail()
                    SetButtons(1)
                    SetHeader(1)
                elseif dataType == 1 then 
                    UnloadTextsAndJobLists()
                    SetButtons(2)
                    OpenTexts()
                elseif dataType == 2 then 
                    UnloadContacts()
                elseif dataType == 4 then 
                    UnloadTextsAndJobLists()
                    SetButtons(4)
                    OpenJobList()
                elseif dataType == 5 then 
                    UnloadAllSettings()
                    OpenSettings()
                    SetHeader(6)
                end
                appList = appList - 1
            elseif IsControlJustPressed(0, 176) then -- Enter 
                PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Michael", true)
                if dataType == 0 then 
                    
                elseif dataType == 1 then 
                    
                elseif dataType == 2 then 
                    
                elseif dataType == 3 then 
                    
                elseif dataType == 4 then 
                    if jobListInv[previousList + 1][7] then 
                        TriggerServerEvent(jobListInv[previousList + 1][6], jobListInv[previousList + 1][2])
                    else 
                        TriggerEvent(jobListInv[previousList + 1][6], jobListInv[previousList + 1][2])
                    end
                    UnloadTextsAndJobLists()
                    DisablePhone()
                elseif dataType == 5 then 
                    if previousList == 0 then 
                        SetBackground(altPlacement + 1)
                    elseif previousList == 4 then 
                        SetTheme(altPlacement + 1)
                    end
                    SetHeader(6)
                    UnloadAllSettings()
                    OpenSettings()
                elseif dataType == 6 then 
                    
                elseif dataType == 7 then 
                    
                elseif dataType == 8 then 
                    
                end
                appList = appList - 1
            end
        else
            Wait(100)
        end
    end
end)

CreateThread(function()
    while true do 
        Wait(500)
        if phoneActive and displayTime then
            local h, m = GetClockHours(), GetClockMinutes()
            
            BeginScaleformMovieMethod(scaleform, "SET_TITLEBAR_TIME")
            ScaleformMovieMethodAddParamInt(h)
            ScaleformMovieMethodAddParamInt(m)
            EndScaleformMovieMethod()   
        end
    end        
end)

-- Utils
function InfoMsg(text)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandThefeedPostTicker(true, true)
end

function InfoMsgExtra(senderId, title, description, icon, avatar)
    if type(senderId) == " number" then 
        local txd = GetPedMugshot(senderId)
    else 
        local txd = avatar 
    end

    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(description)
    EndTextCommandThefeedPostMessagetext(txd, txd, false, icon, GetPlayerName(GetPlayerFromServerId(senderId)), title)
end

function GetPedMugshot(id)
    local pedheadshotint = RegisterPedheadshot(GetPlayerPed(GetPlayerFromServerId(id)))

    while not IsPedheadshotReady(pedheadshotint) or not IsPedheadshotValid(pedheadshotint) do 
        Wait(0)
    end

    return GetPedheadshotTxdString(pedheadshotint)
end

function LoadTexture(txd)
    RequestStreamedTextureDict(txd)

    while not HasStreamedTextureDictLoaded(txd) do 
        Wait(0)
    end
end

function GetName(name)
    if type(name) == "string" then 
        return name 
    elseif type(name) == "number" then  
        return GetPlayerName(GetPlayerFromServerId(name))
    end
end