texts = {
    {1, "Text Title 1", "This is the content", 12, 1}, -- test texts
    {"2", "Text Title 2", "This is the content", 1, 32},
    {"3", "Text Title 3", "This is the content", 11, 3}
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

local function UnloadTexts()
    BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT_EMPTY")
    ScaleformMovieMethodAddParamInt(6)
    EndScaleformMovieMethod()
end

local function AddText(sender, title, msg, hour, minute)
    UnloadTexts()

    for i = #texts, 1, -1 do 
        texts[i + 1] = texts[i]
    end

    texts[1] = {sender, title, msg, hour, minute}

    PlaySoundFrontend(-1, "Notification", "Phone_SoundSet_Michael", true)
    InfoMsgExtra(sender, title, msg, 1)
end

function OpenTexts()
    LoadTexts()

    BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
    ScaleformMovieMethodAddParamInt(6) -- Type
    ScaleformMovieMethodAddParamInt(altPlacement) -- Place
    EndScaleformMovieMethod()
end

RegisterNetEvent("cl:ifruit:receiveText", AddText)

RegisterCommand("add_text", function(src)
    --InfoMsg("test command")
    AddText(src, "Title Command", "test", 1, 12)
    --InfoMsg(texts[1][2])
end, false)