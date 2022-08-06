settings = {
    {23, "Background"},
    {18, "Invite Sound"},
    {18, "Ringtone"},
    {19, "Snapmatic"},
    {23, "Theme"},
    {20, "Vibrate"}
}

background = {
    {23, "Blue Angels", 10},
    {23, "Blue Shards", 11},
    {23, "Blue Circles", 12},
    {23, "Diamonds", 13},
    {23, "Green Glow", 14},
    {23, "Green Shards", 9},
    {23, "Green Squares", 5},
    {23, "Green Triangles", 8},
    {23, "Orange 8-Bit", 15},
    {23, "Orange Halftone", 7},
    {23, "Orange Herringbone", 6},
    {23, "Orange Triangles", 16},
    {23, "Purple Glow", 4},
    {23, "Purple Tartan", 17}
}

theme = {
    {23, "Blue", 1},
    {23, "Green", 2},
    {23, "Grey", 5},
    {23, "Orange", 4},
    {23, "Pink", 7},
    {23, "Purple", 6},
    {23, "Red", 3},
}

local function LoadSettings()
    for i = 1, #settings do 
        BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
        ScaleformMovieMethodAddParamInt(22)
        ScaleformMovieMethodAddParamInt(i - 1)
        ScaleformMovieMethodAddParamInt(settings[i][1])
        ScaleformMovieMethodAddParamPlayerNameString(settings[i][2])
        EndScaleformMovieMethod()
    end
end

local function LoadBackgrounds()
    UnloadAllSettings()
    for i = 1, #background do 
        BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
        ScaleformMovieMethodAddParamInt(22)
        ScaleformMovieMethodAddParamInt(i - 1)
        ScaleformMovieMethodAddParamInt(background[i][1])
        ScaleformMovieMethodAddParamPlayerNameString(background[i][2])
        EndScaleformMovieMethod()
    end

    BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
    ScaleformMovieMethodAddParamInt(22) 
    ScaleformMovieMethodAddParamInt(altPlacement) 
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(scaleform, "SET_HEADER")
    ScaleformMovieMethodAddParamPlayerNameString(background[currentBackground][2])
    EndScaleformMovieMethod()
end

local function LoadThemes()
    UnloadAllSettings()
    for i = 1, #theme do 
        BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
        ScaleformMovieMethodAddParamInt(22)
        ScaleformMovieMethodAddParamInt(i - 1)
        ScaleformMovieMethodAddParamInt(theme[i][1])
        ScaleformMovieMethodAddParamPlayerNameString(theme[i][2])
        EndScaleformMovieMethod()
    end

    print(altPlacement)

    BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
    ScaleformMovieMethodAddParamInt(22) 
    ScaleformMovieMethodAddParamInt(altPlacement) 
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(scaleform, "SET_HEADER")
    ScaleformMovieMethodAddParamPlayerNameString(theme[currentTheme][2])
    EndScaleformMovieMethod()
end

--[[
    10 = File check
    12 = File check
    18 = Sound turned on
    19 = Email notification -> Snapmatic
    20 = Vibrate 
    21 = Muted
    22 = 18 
    23 = Change Theme
    25 = Profile
    26 = Zz
]]

function UnloadAllSettings()
    altPlacement = 0
    BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT_EMPTY")
    ScaleformMovieMethodAddParamInt(22)
    EndScaleformMovieMethod()
end

function OpenSettingsType(num)
    altPlacement = 0
    if num == 0 then -- Background
        LoadBackgrounds()
        appList = appList + 1
    elseif num == 1 then -- Invite sound
        InfoMsg(notAvailable)
    elseif num == 2 then -- Ringtone
        InfoMsg(notAvailable)
    elseif num == 3 then -- Snapmatic
        InfoMsg(notAvailable)
    elseif num == 4 then -- Themes
        LoadThemes()
        appList = appList + 1
    elseif num == 5 then -- Vibrate
        InfoMsg(notAvailable)
    end
end

function OpenSettings()
    altPlacement = 0
    LoadSettings()

    BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
    ScaleformMovieMethodAddParamInt(22) 
    ScaleformMovieMethodAddParamInt(altPlacement) 
    EndScaleformMovieMethod()
end