contacts = {
    {1}
}

local txd = {
    "CHAR_MULTIPLAYER"
}

local function LoadPlayerContacts()
    LoadTexture(txd[1])
    for i = 1, #contacts do 
        BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
        ScaleformMovieMethodAddParamInt(2)
        ScaleformMovieMethodAddParamInt(i - 1)
        ScaleformMovieMethodAddParamInt(0) -- SYSTEM::TO_FLOAT(0), 0f, -1f, -1f, "CELL_7001", &(Global_1998[Global_7451 /*29*/].f_3), &(Global_1998[Global_7451 /*29*/].f_7), 0, 0
        --BeginTextCommandScaleformString("CELL_7003")
        --EndTextCommandScaleformString()
        ScaleformMovieMethodAddParamPlayerNameString("NIELS") -- Text
        ScaleformMovieMethodAddParamPlayerNameString("test")
        ScaleformMovieMethodAddParamTextureNameString(txd[1]) -- Profile picture
        EndScaleformMovieMethod()
    end
end

local function UnloadContacts()
    BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT_EMPTY")
    ScaleformMovieMethodAddParamInt(2)
    EndScaleformMovieMethod()
end

local function AddContact()
    UnloadContacts()

    for i = #contacts, 1, -1 do 
        contacts[i + 1] = contacts[i]
    end

    contacts[1] = {sender, title, msg, hour, minute}

    PlaySoundFrontend(-1, "Notification", "Phone_SoundSet_Michael", true)
end

function OpenContacts()
    LoadPlayerContacts()

    BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
    ScaleformMovieMethodAddParamInt(2) 
    ScaleformMovieMethodAddParamInt(altPlacement) 
    EndScaleformMovieMethod()
end

RegisterNetEvent("cl:ifruit:addContact", AddContact)