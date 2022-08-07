emails = {
    {1, "Email Title1", "This is the content1", false, false}, -- test emails
    {1, "Email Title2", "This is the content2", false, false},
    {1, "Email Title3", "This is the content3", false, false},
    {2, "Email Title4", "This is the content4", false, false}
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

    emails[1] = {sender, title, msg, false, withFile}
    
    PlaySoundFrontend(-1, "Notification", "Phone_SoundSet_Michael", true)
    InfoMsgExtra(sender, title, msg, 2)
end

function UnloadFullEmails()
    altPlacement = 0
    BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT_EMPTY")
    ScaleformMovieMethodAddParamInt(9)
    EndScaleformMovieMethod()
end

function UnloadEmails()
    altPlacement = 0
    BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT_EMPTY")
    ScaleformMovieMethodAddParamInt(8)
    EndScaleformMovieMethod()
end 

function OpenEmailText(num)
    altPlacement = 0
    num = num + 1
    
    if not emails[num][4] then 
        emails[num][4] = true
    end

    BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(9)
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamPlayerNameString("To: " .. GetPlayerName(PlayerId()))
    ScaleformMovieMethodAddParamPlayerNameString("From: " .. GetName(emails[num][1]))
    ScaleformMovieMethodAddParamPlayerNameString(emails[num][2])
    ScaleformMovieMethodAddParamPlayerNameString(emails[num][3])
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
    ScaleformMovieMethodAddParamInt(9) 
    ScaleformMovieMethodAddParamInt(altPlacement) 
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