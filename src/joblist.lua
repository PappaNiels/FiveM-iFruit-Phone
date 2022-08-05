jobListInv = {
    {1, "Title", "Description", 1}
}

-- Description (not in list)
-- Heist :  For heists
-- Else -> Invite to (...)

local function LoadJobList()
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

local function AddInvite(sender, title, description)
    for i = #jobListInv, 1, -1 do 
        jobListInv[i + 1] = jobListInv[i]
    end

    jobListInv[1] = {sender, title, description, colour}

    InfoMsg(sender, title, description, 0)
end

function UnloadJobList()
    BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT_EMPTY")
    ScaleformMovieMethodAddParamInt(20)
    EndScaleformMovieMethod()
end

function OpenJobList()
    LoadJobList()

    BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
    ScaleformMovieMethodAddParamInt(20) 
    ScaleformMovieMethodAddParamInt(altPlacement) 
    EndScaleformMovieMethod()
end

RegisterNetEvent("cl:ifruit:invitePlayer", AddInvite)