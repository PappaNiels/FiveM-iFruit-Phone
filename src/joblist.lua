jobListInv = {
    -- id or name, Title, Description, Colour, EventName, isServerEvent
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
            --LoadTexture("char_default") 
            BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
            ScaleformMovieMethodAddParamInt(20)
            ScaleformMovieMethodAddParamInt(i - 1)
            ScaleformMovieMethodAddParamPlayerNameString(GetName(jobListInv[i][1])) -- Title
            ScaleformMovieMethodAddParamPlayerNameString(jobListInv[i][2]) -- Description


            ScaleformMovieMethodAddParamInt(-1)
            ScaleformMovieMethodAddParamInt(21) --Colour
            --[[ 
            1 = Heist green
            2 = Red
            3 = Yellow
            4 = Beige
            5 = Pink
            6 = White
            7 = Blue
            8 = Purple
            9 = Green/Blue 
            10 = White 
            11 = Orange 
            12 = Green/Blue 
            13 = Pink
            14 = Blue
            15 = Light Green
            16 = Yellow
            17 = Light blue
            18 = Grey
            19 = Green/Blue
            20 = Light Blue
            ]]
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
    LoadTexture(jobListInv[num + 1][5])
    BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(7)
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamPlayerNameString(GetName(jobListInv[num + 1][1]))
    ScaleformMovieMethodAddParamPlayerNameString(jobListInv[num + 1][2] .. "\n" .. jobListInv[num + 1][3])
    ScaleformMovieMethodAddParamPlayerNameString(jobListInv[num + 1][5])
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