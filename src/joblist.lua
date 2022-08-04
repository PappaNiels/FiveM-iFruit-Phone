jobListInv = {1}

local function LoadJobList()
    for i = 1, #jobListInv do
        LoadTexture("char_default") 
        BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
        ScaleformMovieMethodAddParamInt(28)
        ScaleformMovieMethodAddParamInt(0)
        --ScaleformMovieMethodAddParamInt(2)
        ScaleformMovieMethodAddParamPlayerNameString("test1") -- Name
        ScaleformMovieMethodAddParamPlayerNameString("test2") -- Description  
        ScaleformMovieMethodAddParamPlayerNameString("char_default") -- Profile picture
        EndScaleformMovieMethod()
    end
end

local function AddInvite(sender, title, description, icon)
    for i = #jobListInv, 1, -1 do 
        jobListInv[i + 1] = jobListInv[i]
    end

    jobListInv[1] = {sender, title, description, icon}
end

function UnloadJobList()
    BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT_EMPTY")
    ScaleformMovieMethodAddParamInt(18)
    EndScaleformMovieMethod()
end

function OpenJobList()
    LoadJobList()

    BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
    ScaleformMovieMethodAddParamInt(28) 
    ScaleformMovieMethodAddParamInt(altPlacement) 
    EndScaleformMovieMethod()
end

RegisterNetEvent("cl:ifruit:invitePlayer", AddInvite)