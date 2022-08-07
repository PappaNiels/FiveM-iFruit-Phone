jobListInv = {
    -- Id or name, Title, Description, Colour, EventName, isServerEvent
    {1, "Title1", "Description1", 1, "char_default", "clientEventName", false},
    {1, "Title2", "Description2", 1, "char_default", "serverEventName", true}
}

-- Title :
-- Heist :  For heists
-- Else -> Invite to (...)

local function LoadJobList()
    if #jobListInv == 0 then 
        BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
        ScaleformMovieMethodAddParamInt(20)
        ScaleformMovieMethodAddParamInt(0)
        ScaleformMovieMethodAddParamPlayerNameString("No Jobs")
        ScaleformMovieMethodAddParamPlayerNameString("available to join")
        ScaleformMovieMethodAddParamInt(-1)
        ScaleformMovieMethodAddParamInt(18)
        ScaleformMovieMethodAddParamBool(true)
        EndScaleformMovieMethod()
        
    else
        for i = 1, #jobListInv do
            BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
            ScaleformMovieMethodAddParamInt(20)
            ScaleformMovieMethodAddParamInt(i - 1)
            ScaleformMovieMethodAddParamPlayerNameString(GetName(jobListInv[i][1])) -- Title
            ScaleformMovieMethodAddParamPlayerNameString(jobListInv[i][2]) -- Description
            ScaleformMovieMethodAddParamInt(-1)
            ScaleformMovieMethodAddParamInt(21) --Colour
            ScaleformMovieMethodAddParamBool(true) -- Normal = true, Weird beige = false
            EndScaleformMovieMethod()
        end
    end
end

local function AddInvite(sender, title, description, colour, char, eventName, isServerEvent)
    for i = #jobListInv, 1, -1 do 
        jobListInv[i + 1] = jobListInv[i]
    end

    jobListInv[1] = {sender, title, description, colour, char, eventName, isServerEvent}

    InfoMsg(sender, title, description, 0)
end

function UnloadJobList()
    altPlacement = 0
    BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT_EMPTY")
    ScaleformMovieMethodAddParamInt(20)
    EndScaleformMovieMethod()
end

function UnloadTextsAndJobLists()
    BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT_EMPTY")
    ScaleformMovieMethodAddParamInt(7)
    EndScaleformMovieMethod()
end

function OpenJobListInvite(num)
    num = num + 1
    altPlacement = 0
    LoadTexture(jobListInv[num][5])
    BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(7)
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamPlayerNameString(GetName(jobListInv[num][1]))
    ScaleformMovieMethodAddParamPlayerNameString(jobListInv[num][2] .. "\n" .. jobListInv[num][3])
    ScaleformMovieMethodAddParamPlayerNameString(jobListInv[num][5])
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
    ScaleformMovieMethodAddParamInt(7) 
    ScaleformMovieMethodAddParamInt(0) 
    EndScaleformMovieMethod()
end

function OpenJobList()
    altPlacement = 0
    LoadJobList()

    BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
    ScaleformMovieMethodAddParamInt(20) 
    ScaleformMovieMethodAddParamInt(altPlacement) 
    EndScaleformMovieMethod()
end

RegisterNetEvent("cl:ifruit:invitePlayer", AddInvite)