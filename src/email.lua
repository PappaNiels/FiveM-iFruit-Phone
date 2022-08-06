emails = {
    {1, "Email Title", "This is the content", false, false}, -- test emails
    {1, "Email Title", "This is the content", false, false},
    {1, "Email Title", "This is the content", false, false},
    {2, "Email Title", "This is the content", false, false}
}

local function LoadEmails()
    for i = 1, #emails do 
        BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
        ScaleformMovieMethodAddParamInt(8) -- Type
        ScaleformMovieMethodAddParamInt(i - 1) -- Place
        ScaleformMovieMethodAddParamBool(emails[i][4]) -- Read
        ScaleformMovieMethodAddParamBool(emails[i][5]) -- With File
        ScaleformMovieMethodAddParamPlayerNameString(GetName(emails[i][1])) -- Sender
        ScaleformMovieMethodAddParamPlayerNameString(emails[i][2]) -- Email Title
        EndScaleformMovieMethod()
    end
end

local function AddEmail(sender, title, msg, withFile)
    UnloadEmails()

    for i = #emails, 1, -1 do 
        emails[i + 1] = emails[i]
    end

    emails[1] = {sender, title, msg, false, minute}
    
    PlaySoundFrontend(-1, "Notification", "Phone_SoundSet_Michael", true)
    InfoMsgExtra(sender, title, msg, 2)
end

function UnloadEmails()
    altPlacement = 0
    BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT_EMPTY")
    ScaleformMovieMethodAddParamInt(8)
    EndScaleformMovieMethod()
end 

function OpenEmail()
    altPlacement = 0
    LoadEmails()

    BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
    ScaleformMovieMethodAddParamInt(8) 
    ScaleformMovieMethodAddParamInt(altPlacement) 
    EndScaleformMovieMethod()
end

RegisterNetEvent("cl:ifruit:receiveEmail", AddEmail)