scaleform = 0
altPlacement = 0
appList = 0
dataType = 0

local phoneActive = false 
local sleepMode = false
local inApp = false 
local isPhoneRotated = false

local currentTheme = 5
local currentBackground = 11
local placement = 4 

local headers = {
    "Email",
    "Texts",
    "Contacts",
    "Quick ",
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
        return #contacts
    elseif dataType == 4 then -- Job List
        return #jobListInv
    elseif dataType == 5 then -- Settings
        return #settings
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
        return 7
    elseif app == 5 then 
        return 7
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

local function SetTheme(theme)
    currentTheme = theme

    BeginScaleformMovieMethod(scaleform, "SET_THEME")
    ScaleformMovieMethodAddParamInt(currentTheme)
    EndScaleformMovieMethod()
end

local function SetBackground(background)
    currentBackground = background 

    BeginScaleformMovieMethod(scaleform, "SET_BACKGROUND_IMAGE")
    ScaleformMovieMethodAddParamInt(currentBackground)
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

        BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
        ScaleformMovieMethodAddParamInt(app) -- Type
        ScaleformMovieMethodAddParamInt(altPlacement) -- Place
        EndScaleformMovieMethod()
    end
end

--local function OpenTexts()
--    BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
--    ScaleformMovieMethodAddParamInt(6) -- Type
--    ScaleformMovieMethodAddParamInt(altPlacement) -- Place
--    EndScaleformMovieMethod()
--end--

--local function OpenContacts()
--    BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
--    ScaleformMovieMethodAddParamInt(2) -- Type
--    ScaleformMovieMethodAddParamInt(altPlacement) -- Place
--    EndScaleformMovieMethod()
--end--

local function OpenQuick()
    InfoMsg("This part of the phone does not exist (yet)...")
end--

--local function OpenJobList()
--    BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
--    ScaleformMovieMethodAddParamInt(7) -- Type
--    ScaleformMovieMethodAddParamInt(altPlacement) -- Place
--    EndScaleformMovieMethod()
--end--

--local function OpenSettings()
--    
--end--

local function OpenCamera()
    InfoMsg("This part of the phone does not exist (yet)...")
end--

local function OpenInternet()
    InfoMsg("This part of the phone does not exist (yet)...")
end--

--local function OpenSecuroServ()--

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
    6 = Texts
    7 = Undefined Settings etc?
    8 = Email list
    9 = Email 
    11 = ?
    18 = ?
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
            Wait(500)
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
                elseif placement == 6 then
                    OpenCamera()
                elseif placement == 7 then
                    OpenInternet()
                elseif placement == 8 then
                    OpenSecuroServ()
                end
                dataType = placement
                --inApp = true
            elseif IsControlJustPressed(0, 177) then -- Backspace
                PlaySoundFrontend(-1, "Menu_Back", "Phone_SoundSet_Michael", true)
                MovePhone(false)
                DisablePhone()
            end
            --print(appList)
        elseif not phoneActive then  
            if IsControlJustPressed(0, 27) then 
                LoadScaleform()
                PlaySoundFrontend(-1, "Pull_Out", "Phone_SoundSet_Michael", true)

                phoneActive = true

                --SetMobilePhonePosition()
                SetMobilePhoneScale(250.0)
                --SetMobilePhoneRotation(-90.0, 0.0, 90.0)
                SetMobilePhoneRotation(-90.0, 0.0, 0.0)
                SetMobilePhonePosition(61.5, -68.0, -60.0)
                CreateMobilePhone(0)

                SetSleepMode(sleepMode)
                SetTheme(currentTheme)
                SetBackground(currentBackground)
                SetAppsHome()
                
                --SetMobilePhonePosition(56.0, -28.0, -60.0)
                --print(GetMobilePhonePosition().y)
                MovePhone(true)
            end
        else 
            Wait(100)
        end
    end
end)

CreateThread(function()
    while true do 
        Wait(0)
        if appList > 0 then
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
                    RotatePhone(false)
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

function GetNameOfSender(name)
    if type(name) == "string" then
        print(name) 
        return name 
    elseif type(name) == "number" then 
        print(name) 
        return GetPlayerName(GetPlayerFromServerId(name))
    end
end

function NewContact()

end