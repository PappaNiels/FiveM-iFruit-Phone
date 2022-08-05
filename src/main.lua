scaleform = 0
altPlacement = 0
appList = 0
dataType = 0
currentTheme = 2
currentBackground = 9
previousList = 0

local phoneActive = false 
local sleepMode = false
local inApp = false 
local isPhoneRotated = false
local hackSecuroserv = false 

local placement = 4 

local headers = {
    "Email",
    "Texts",
    "Contacts",
    "Quick Job",
    "Job List",
    "Settings",
    "Snapmatic",
    "Internet",
    "SecuroServ"
}

local icons = {4, 2, 5, 14, 12, 24, 1, 6, 57}

local function LoadScaleform()
    scaleform = RequestScaleformMovie("CELLPHONE_IFRUIT")
    RequestStreamedTextureDict("cellphone_ifruit")

    while not HasScaleformMovieLoaded(scaleform) do 
        Wait(0)
    end
end

local function RotatePhone(toEmail)
    isPhoneRotated = toEmail
    if toEmail then 
        CreateThread(function()
            while GetMobilePhonePosition().x > 56 do 
                SetMobilePhonePosition(GetMobilePhonePosition().x - 1, -28.0, -60.0)
                Wait(2)
            end
            while GetMobilePhoneRotation().z < 89 do 
                SetMobilePhoneRotation(-90.0, 0.0, GetMobilePhoneRotation().z + 2)
                Wait(1)
            end
        end)
    else 
        CreateThread(function()
            while GetMobilePhonePosition().x < 61.5 do 
                SetMobilePhonePosition(GetMobilePhonePosition().x + 1, -28.0, -60.0)
                Wait(2)
            end
            while GetMobilePhoneRotation().z > 1 do 
                SetMobilePhoneRotation(-90.0, 0.0, GetMobilePhoneRotation().z - 2)
                Wait(1)
            end
        end)
    end
end

local function MovePhone(up)
    if up then 
        while GetMobilePhonePosition().y < -27 do 
            SetMobilePhonePosition(61.5, GetMobilePhonePosition().y + 4, -60.0)
            Wait(1)
        end
    else
        while GetMobilePhonePosition().y > -67 do 
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
        return 11
    elseif app == 5 then 
        return 22
    elseif app == 8 then 
        return 1 
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

    BeginScaleformMovieMethod(scaleform, "SET_THEME")
    ScaleformMovieMethodAddParamInt(theme[currentTheme][3])
    EndScaleformMovieMethod()
end

local function SetHeader()
    BeginScaleformMovieMethod(scaleform, "SET_HEADER")
    ScaleformMovieMethodAddParamPlayerNameString(headers[placement])
    EndScaleformMovieMethod()
end

local function SetBackground(_background)
    currentBackground = _background 

    BeginScaleformMovieMethod(scaleform, "SET_BACKGROUND_IMAGE")
    ScaleformMovieMethodAddParamInt(background[currentBackground][3])
    EndScaleformMovieMethod()
end

local function SetPlacement(app, change)
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

local function OpenQuick()
    InfoMsg("This part of the phone does not exist (yet)...")
end--

--local function OpenJobList()
--    BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
--    ScaleformMovieMethodAddParamInt(7) -- Type
--    ScaleformMovieMethodAddParamInt(altPlacement) -- Place
--    EndScaleformMovieMethod()
--end--

local function OpenCamera()
    InfoMsg("This part of the phone does not exist (yet)...")
end--

local function OpenInternet()
    InfoMsg("This part of the phone does not exist (yet)...")
end--

--local function OpenSecuroServ()

--end

--[[
    1 = Camera 
    2 = Text
    3 = Nothing 
    4 = Email
    5 = Contacts
    6 = Internet
    11 = Contacts +
    12 = Job List
    13 = Empty
    14 = Quick (Access)
    15 = Empty
    17 = Empty
    24 = Settings
    27 = Exclamation point
    31 = Empty
    32 = Empty
    35 = Controller
    36 = Empty
    37 = Empty
    38 = Back
    39 = File X
    40 = Target
    41 = Empty
    42 = Trackify
    43 = Save Game Data
    44 - 48 = Camera 
    49 = Megephone
    50 = Controller
    51 - 53 = Camera
    54 = VLSI
    55 = Camera
    56 = Benny's
    57 = SecuroServ 


    Type 
    1 = Homepage
    2 = Contacts 
    3 = Homepage
    4 = Call 
    5 = Homepage
    6 = Texts list
    7 = Text
    8 = Email list
    9 = Email 
    11 = Keypad
    13 = Settings
    14 = ? (forced colour header is brown??)
    15 = List for 14
    16 = Black screen
    17 = List for 14
    18 = Settings
    19 = ? List
    22 = Settings 
    23 = Trackify
    24 = Coords int(24), int, bool, string, int, int, int, int, int, int, string, int, int, int
    25 = Job list beige
    26 = Black text
    27 = SecuroServ Hack no signal

    Text layout
    LoadTexture("char_default") 
    BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(7)
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamPlayerNameString("test1") -- Name
    ScaleformMovieMethodAddParamPlayerNameString("test2") -- Description  
    ScaleformMovieMethodAddParamPlayerNameString("char_default") -- Profile picture
    EndScaleformMovieMethod()
    
]]

local function SetAppsHome()
    for i = 0 , 9 do 
        BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
        ScaleformMovieMethodAddParamInt(1) -- Type 
        ScaleformMovieMethodAddParamInt(i) -- Place 
        ScaleformMovieMethodAddParamInt(icons[i + 1]) -- Icon
        EndScaleformMovieMethod()
    end

    BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
    ScaleformMovieMethodAddParamInt(1) -- Type
    ScaleformMovieMethodAddParamInt(placement) -- Place
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(scaleform, "SET_HEADER")
    ScaleformMovieMethodAddParamPlayerNameString("Job List")
    EndScaleformMovieMethod()
end

local function DisablePhone()
    DestroyMobilePhone()
    SetScaleformMovieAsNoLongerNeeded(scaleform)
    SetPauseMenuActive(true)
    phoneActive = false 
    placement = 4
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
                if placement == 0 then 
                    OpenEmail()
                    RotatePhone(true)
                    appList = 1
                elseif placement == 1 then
                    OpenTexts()
                    appList = 1
                elseif placement == 2 then
                    OpenContacts()
                    appList = 1
                elseif placement == 3 then
                    OpenQuick()
                elseif placement == 4 then
                    OpenJobList()
                    appList = 1
                elseif placement == 5 then
                    OpenSettings()
                    appList = 1
                elseif placement == 6 then
                    OpenCamera()
                elseif placement == 7 then
                    OpenInternet()
                elseif placement == 8 then
                    if not hackSecuroserv then 
                        --OpenSecuroServ()
                        InfoMsg("This part of the phone does not exist (yet)... ")
                    else 
                        OpenSecuroServHack()
                    end
                end
                dataType = placement
            elseif IsControlJustPressed(0, 177) then -- Backspace
                PlaySoundFrontend(-1, "Menu_Back", "Phone_SoundSet_Michael", true)
                MovePhone(false)
                DisablePhone()
            end
        elseif not phoneActive then  
            if IsControlJustPressed(0, 27) then 
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
                phoneActive = true
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
                altPlacement = 0
                appList = appList - 1
            elseif IsControlJustPressed(0, 176) then -- Enter
                PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Michael", true)
                previousList = altPlacement
                if dataType == 0 then 
                    OpenEmailText(altPlacement)
                    appList = appList + 1
                elseif dataType == 1 then
                    OpenTextsText(altPlacement)
                    appList = appList + 1
                elseif dataType == 2 then 
                    Call(altPlacement)
                    appList = appList + 1
                elseif dataType == 3 then 
                    
                elseif dataType == 4 then 
                    OpenJobText(altPlacement)
                    appList = appList + 1
                elseif dataType == 5 then 
                    OpenSettingsType(altPlacement)
                elseif dataType == 6 then 
                    
                elseif dataType == 7 then 
                    
                elseif dataType == 8 then 
                    
                end
                --altPlacement = 0
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
                    UnloadEmails()
                elseif dataType == 1 then 
                    UnloadTexts()
                elseif dataType == 2 then 
                    UnloadContacts()
                elseif dataType == 4 then 
                    UnloadJobList()
                elseif dataType == 5 then 
                    UnloadAllSettings()
                    OpenSettings()
                    SetHeader()
                end
                altPlacement = 0
                appList = appList - 1
            elseif IsControlJustPressed(0, 176) then -- Enter 
                PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Michael", true)
                if dataType == 0 then 
                    
                elseif dataType == 1 then 
                    
                elseif dataType == 2 then 
                    
                elseif dataType == 3 then 
                    
                elseif dataType == 4 then 
                    
                elseif dataType == 5 then 
                    if previousList == 0 then 
                        SetBackground(altPlacement + 1)
                    elseif previousList == 4 then 
                        SetTheme(altPlacement + 1)
                    end
                    SetHeader()
                    UnloadAllSettings()
                    OpenSettings()
                elseif dataType == 6 then 
                    
                elseif dataType == 7 then 
                    
                elseif dataType == 8 then 
                    
                end
                altPlacement = 0
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
        if phoneActive then
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

function InfoMsgExtra(senderId, title, description, icon)
    local txd = GetPedMugshot(senderId)
    
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

function NewContact()

end