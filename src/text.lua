texts = {
    {1, "Text Title 1", "This is the content", 12, 1, "char_default", false}, -- test texts
    {"2", "Text Title 2", "This is the content", 1, 32, "char_default", false},
    {"3", "Text Title 3", "This is the content", 11, 3, "char_default", false}
}

local function LoadTexts()
    for i = 1, #texts do 
        BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
        ScaleformMovieMethodAddParamInt(6) -- Type
        ScaleformMovieMethodAddParamInt(i - 1) -- Place
        ScaleformMovieMethodAddParamInt(texts[i][4]) -- Time Hours
        ScaleformMovieMethodAddParamInt(texts[i][5]) -- Time Minutes
        ScaleformMovieMethodAddParamInt(texts[i][5]) -- Time Minutes
        ScaleformMovieMethodAddParamPlayerNameString(GetName(texts[i][1])) -- Sender
        ScaleformMovieMethodAddParamPlayerNameString(texts[i][2]) -- Text Title
        ScaleformMovieMethodAddParamBool(false)

        EndScaleformMovieMethod()
    end
end

local function AddText(sender, title, msg, hour, minute, avatar)
    UnloadTexts()

    for i = #texts, 1, -1 do 
        texts[i + 1] = texts[i]
    end

    texts[1] = {sender, title, msg, hour, minute, avatar, false}

    SetUnread(1)
    PlaySoundFrontend(-1, "Notification", "Phone_SoundSet_Michael", true)
    InfoMsgExtra(sender, title, msg, 1, avatar)
end

function UnloadTexts()
    BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT_EMPTY")
    ScaleformMovieMethodAddParamInt(6)
    EndScaleformMovieMethod()
end

function OpenTextsText(num)
    num = num + 1
    altPlacement = 0

    if not texts[num][7] then 
        texts[num][7] = true
        SetUnread(1)
    end

    LoadTexture(texts[num][6])
    BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(7)
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamPlayerNameString(GetName(texts[num][1]))
    ScaleformMovieMethodAddParamPlayerNameString(texts[num][2])
    ScaleformMovieMethodAddParamPlayerNameString(texts[num][6])
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
    ScaleformMovieMethodAddParamInt(7) 
    ScaleformMovieMethodAddParamInt(0) 
    EndScaleformMovieMethod()
end

function OpenTexts()
    altPlacement = 0
    LoadTexts()

    BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
    ScaleformMovieMethodAddParamInt(6) -- Type
    ScaleformMovieMethodAddParamInt(altPlacement) -- Place
    EndScaleformMovieMethod()
end

RegisterNetEvent("cl:ifruit:receiveText", AddText)