contacts = {}

standardContacts = {}

if useStandardContacts then 
    if GetGameBuildNumber() == 1604 then 
        standardContacts = {
            {"Agent 14", "char_agent14"},
            {"Assistant", assistant},
            {"Brucie", "char_mp_brucie"},
            {"Bryony", "char_bryony"},
            {"Captian", "char_boatsite2"},
            {"Chastity", "char_stripper_chastity"},
            {"Cheetah", "char_stripper_cheetah"},
            {"Dom", "char_dom"},
            {"Downtown Cab Co.", "char_taxi"},
            {"Emergency Services", "char_call911"},
            {"English Dave", "char_english_dave"},
            {"Fufu", "char_stripper_fufu"},
            {"Gerald", "char_mp_gerald"},
            {"Infernus", "char_stripper_infernus"},
            {"Juliet", "char_stripper_juliet"},
            {"Lamar", "char_lamar"},
            {"Lazlow", "char_lazlow2"},
            {"Lester", "char_lester"},
            {"LJT", "char_ljt"},
            {"Malc", "char_malc"},
            {"Martin", "char_martin"},
            {"Mechanic", "char_ls_customs"},
            {"Merryweather", "char_mp_merryweather"},
            {"Mors Mutual Insurance", "char_mp_mors_mutual"},
            {"Nikki", "char_stripper_nikki"},
            {"Paige", "char_paige"},
            {"Peach", "char_stripper_peach"},
            {"Pegasus", "char_pegasus_delivery"},
            {"Ron", "char_ron"},
            {"Sapphire", "char_stripper_sapphire"},
            {"Simeon", "char_simeon"},
            {"Tony", "char_tony_prince"}
        }
    elseif GetGameBuildNumber() == 2060 then
        standardContacts = {
            {"Agent 14", "char_agent14"},
            {"Assistant", assistant},
            {"Brucie", "char_mp_brucie"},
            {"Bryony", "char_bryony"},
            {"Captian", "char_boatsite2"},
            {"Chastity", "char_stripper_chastity"},
            {"Cheetah", "char_stripper_cheetah"},
            {"Dom", "char_dom"},
            {"Downtown Cab Co.", "char_taxi"},
            {"Emergency Services", "char_call911"},
            {"English Dave", "char_english_dave"},
            {"Fufu", "char_stripper_fufu"},
            {"Gerald", "char_mp_gerald"},
            {"Infernus", "char_stripper_infernus"},
            {"Juliet", "char_stripper_juliet"},
            {"Lamar", "char_lamar"},
            {"Lazlow", "char_lazlow2"},
            {"Lester", "char_lester"},
            {"LJT", "char_ljt"},
            {"Malc", "char_malc"},
            {"Martin", "char_martin"},
            {"Mechanic", "char_ls_customs"},
            {"Merryweather", "char_mp_merryweather"},
            {"Mors Mutual Insurance", "char_mp_mors_mutual"},
            {"Ms. Baker", "char_casino_manager"},
            {"Nikki", "char_stripper_nikki"},
            {"Paige", "char_paige"},
            {"Peach", "char_stripper_peach"},
            {"Pegasus", "char_pegasus_delivery"},
            {"Ron", "char_ron"},
            {"Sapphire", "char_stripper_sapphire"},
            {"Simeon", "char_simeon"},
            {"Tony", "char_tony_prince"},
            {"Wendy", "char_wendy"},
            {"Yung Ancestor", "char_tw"}
        }
    elseif GetGameBuildNumber() == 2189 then
        standardContacts = {
            {"Agent 14", "char_agent14"},
            {"Assistant", assistant},
            {"Brucie", "char_mp_brucie"},
            {"Bryony", "char_bryony"},
            {"Captian", "char_boatsite2"},
            {"Chastity", "char_stripper_chastity"},
            {"Cheetah", "char_stripper_cheetah"},
            {"Dom", "char_dom"},
            {"Downtown Cab Co.", "char_taxi"},
            {"Emergency Services", "char_call911"},
            {"English Dave", "char_english_dave"},
            {"Fufu", "char_stripper_fufu"},
            {"Gerald", "char_mp_gerald"},
            {"Infernus", "char_stripper_infernus"},
            {"Juliet", "char_stripper_juliet"},
            {"Lamar", "char_lamar"},
            {"Lazlow", "char_lazlow2"},
            {"Lester", "char_lester"},
            {"LJT", "char_ljt"},
            {"Malc", "char_malc"},
            {"Martin", "char_martin"},
            {"Mechanic", "char_ls_customs"},
            {"Merryweather", "char_mp_merryweather"},
            {"Mors Mutual Insurance", "char_mp_mors_mutual"},
            {"Ms. Baker", "char_casino_manager"},
            {"Nikki", "char_stripper_nikki"},
            {"Paige", "char_paige"},
            {"Pavel", "char_pavel"},
            {"Peach", "char_stripper_peach"},
            {"Pegasus", "char_pegasus_delivery"},
            {"Ron", "char_ron"},
            {"Sapphire", "char_stripper_sapphire"},
            {"Simeon", "char_simeon"},
            {"Tony", "char_tony_prince"},
            {"Wendy", "char_wendy"},
            {"Yung Ancestor", "char_tw"}
        }
    elseif GetGameBuildNumber() == 2372 then
        standardContacts = {
            {"Agent 14", "char_agent14"},
            {"Assistant", assistant},
            {"Brucie", "char_mp_brucie"},
            {"Bryony", "char_bryony"},
            {"Captian", "char_boatsite2"},
            {"Chastity", "char_stripper_chastity"},
            {"Cheetah", "char_stripper_cheetah"},
            {"Dom", "char_dom"},
            {"Downtown Cab Co.", "char_taxi"},
            {"Emergency Services", "char_call911"},
            {"English Dave", "char_english_dave"},
            {"Fufu", "char_stripper_fufu"},
            {"Gerald", "char_mp_gerald"},
            {"Infernus", "char_stripper_infernus"},
            {"Juliet", "char_stripper_juliet"},
            {"Lamar", "char_lamar"},
            {"Lazlow", "char_lazlow2"},
            {"Lester", "char_lester"},
            {"LJT", "char_ljt"},
            {"Malc", "char_malc"},
            {"Martin", "char_martin"},
            {"Mechanic", "char_ls_customs"},
            {"Merryweather", "char_mp_merryweather"},
            {"Mors Mutual Insurance", "char_mp_mors_mutual"},
            {"Ms. Baker", "char_casino_manager"},
            {"Nikki", "char_stripper_nikki"},
            {"Paige", "char_paige"},
            {"Pavel", "char_pavel"},
            {"Peach", "char_stripper_peach"},
            {"Pegasus", "char_pegasus_delivery"},
            {"Ron", "char_ron"},
            {"Sapphire", "char_stripper_sapphire"},
            {"Simeon", "char_simeon"},
            {"Tony", "char_tony_prince"},
            {"Wendy", "char_wendy"},
            {"Yung Ancestor", "char_tw"}
        }
    elseif GetGameBuildNumber() == 2545 then
        standardContacts = {
            {"Agent 14", "char_agent14"},
            {"Assistant", assistant},
            {"Brucie", "char_mp_brucie"},
            {"Bryony", "char_bryony"},
            {"Captian", "char_boatsite2"},
            {"Chastity", "char_stripper_chastity"},
            {"Cheetah", "char_stripper_cheetah"},
            {"Dom", "char_dom"},
            {"Downtown Cab Co.", "char_taxi"},
            {"Emergency Services", "char_call911"},
            {"English Dave", "char_english_dave"},
            {"Franklin", "char_fixfranklin"},
            {"Fufu", "char_stripper_fufu"},
            {"Gerald", "char_mp_gerald"},
            {"Imani", "char_imani"},
            {"Infernus", "char_stripper_infernus"},
            {"Juliet", "char_stripper_juliet"},
            {"Lamar", "char_lamar"},
            {"Lazlow", "char_lazlow2"},
            {"Lester", "char_lester"},
            {"LJT", "char_ljt"},
            {"Malc", "char_malc"},
            {"Martin", "char_martin"},
            {"Mechanic", "char_ls_customs"},
            {"Merryweather", "char_mp_merryweather"},
            {"Mors Mutual Insurance", "char_mp_mors_mutual"},
            {"Ms. Baker", "char_casino_manager"},
            {"Nikki", "char_stripper_nikki"},
            {"Paige", "char_paige"},
            {"Pavel", "char_pavel"},
            {"Peach", "char_stripper_peach"},
            {"Pegasus", "char_pegasus_delivery"},
            {"Ron", "char_ron"},
            {"Sapphire", "char_stripper_sapphire"},
            {"Simeon", "char_simeon"},
            {"Tony", "char_tony_prince"},
            {"Wendy", "char_wendy"},
            {"Yung Ancestor", "char_tw"}
        }
    elseif GetGameBuildNumber() == 2612 then
        standardContacts = {
            {"Agent 14", "char_agent14"},
            {"Assistant", assistant},
            {"Brucie", "char_mp_brucie"},
            {"Bryony", "char_bryony"},
            {"Captian", "char_boatsite2"},
            {"Chastity", "char_stripper_chastity"},
            {"Cheetah", "char_stripper_cheetah"},
            {"Dom", "char_dom"},
            {"Downtown Cab Co.", "char_taxi"},
            {"Emergency Services", "char_call911"},
            {"English Dave", "char_english_dave"},
            {"Franklin", "char_fixfranklin"},
            {"Fufu", "char_stripper_fufu"},
            {"Gerald", "char_mp_gerald"},
            {"Imani", "char_imani"},
            {"Infernus", "char_stripper_infernus"},
            {"Juliet", "char_stripper_juliet"},
            {"Lamar", "char_lamar"},
            {"Lazlow", "char_lazlow2"},
            {"Lester", "char_lester"},
            {"LJT", "char_ljt"},
            {"Malc", "char_malc"},
            {"Martin", "char_martin"},
            {"Mechanic", "char_ls_customs"},
            {"Merryweather", "char_mp_merryweather"},
            {"Mors Mutual Insurance", "char_mp_mors_mutual"},
            {"Ms. Baker", "char_casino_manager"},
            {"Nikki", "char_stripper_nikki"},
            {"Paige", "char_paige"},
            {"Pavel", "char_pavel"},
            {"Peach", "char_stripper_peach"},
            {"Pegasus", "char_pegasus_delivery"},
            {"Ron", "char_ron"},
            {"Sapphire", "char_stripper_sapphire"},
            {"Simeon", "char_simeon"},
            {"Tony", "char_tony_prince"},
            {"Wendy", "char_wendy"},
            {"Yung Ancestor", "char_tw"}
        }
    elseif GetGameBuildNumber() == 2699 then
        standardContacts = {
            {"Agent 14", "char_agent14"},
            {"Assistant", assistant},
            {"Brucie", "char_mp_brucie"},
            {"Bryony", "char_bryony"},
            {"Captian", "char_boatsite2"},
            {"Chastity", "char_stripper_chastity"},
            {"Cheetah", "char_stripper_cheetah"},
            {"Dom", "char_dom"},
            {"Downtown Cab Co.", "char_taxi"},
            {"Emergency Services", "char_call911"},
            {"English Dave", "char_english_dave"},
            {"Franklin", "char_fixfranklin"},
            {"Fufu", "char_stripper_fufu"},
            {"Gerald", "char_mp_gerald"},
            {"Imani", "char_imani"},
            {"Infernus", "char_stripper_infernus"},
            {"Juliet", "char_stripper_juliet"},
            {"Lamar", "char_lamar"},
            {"Lazlow", "char_lazlow2"},
            {"Lester", "char_lester"},
            {"LJT", "char_ljt"},
            {"Malc", "char_malc"},
            {"Martin", "char_martin"},
            {"Mechanic", "char_ls_customs"},
            {"Merryweather", "char_mp_merryweather"},
            {"Mors Mutual Insurance", "char_mp_mors_mutual"},
            {"Ms. Baker", "char_casino_manager"},
            {"Nikki", "char_stripper_nikki"},
            {"Paige", "char_paige"},
            {"Pavel", "char_pavel"},
            {"Peach", "char_stripper_peach"},
            {"Pegasus", "char_pegasus_delivery"},
            {"Ron", "char_ron"},
            {"Sapphire", "char_stripper_sapphire"},
            {"Simeon", "char_simeon"},
            {"Tony", "char_tony_prince"},
            {"Wendy", "char_wendy"},
            {"Yohan", "char_yohan"}, 
            {"Yung Ancestor", "char_tw"}
        }
    end
end

local function LoadPlayerContacts()
    LoadTexture("char_default")
    for i = 1, #GetActivePlayers() do 
        contacts[i] = GetPlayerServerId(GetActivePlayers()[i])
    end
    for i = 1, #contacts do 
        BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
        ScaleformMovieMethodAddParamInt(2) -- Type
        ScaleformMovieMethodAddParamInt(i - 1) -- Position
        ScaleformMovieMethodAddParamBool(false)  -- !
        ScaleformMovieMethodAddParamPlayerNameString(GetName(contacts[i])) -- Text
        ScaleformMovieMethodAddParamTextureNameString("char_default") -- Profile picture
        ScaleformMovieMethodAddParamTextureNameString("char_default") -- Profile picture
        EndScaleformMovieMethod()
    end

    for i = 1, #standardContacts do 
        BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
        ScaleformMovieMethodAddParamInt(2) -- Type
        ScaleformMovieMethodAddParamInt(i + #contacts - 1) -- Position
        ScaleformMovieMethodAddParamBool(false)  -- !
        ScaleformMovieMethodAddParamPlayerNameString(standardContacts[i][1]) -- Text
        ScaleformMovieMethodAddParamTextureNameString(standardContacts[i][2]) -- Profile picture
        ScaleformMovieMethodAddParamTextureNameString(standardContacts[i][2]) -- Profile picture
        EndScaleformMovieMethod()
    end
end

local function AddBomb()
    UnloadContacts()

    LoadTexture("char_detonatebomb")

    for i = #standardContacts, 8, -1 do 
        standardContacts[i + 1] = standardContacts[i]
    end

    standardContacts[8] = {bombContact, "char_detonatebomb"}
end

local function RemoveBomb()
    UnloadContacts()

    for i = 1, #standardContacts do 
        if standardContacts[i][1] == bombContact then 
            standardContacts[i] = nil 
        end
    end
end

function UnloadContacts()
    altPlacement = 0
    BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT_EMPTY")
    ScaleformMovieMethodAddParamInt(2)
    EndScaleformMovieMethod()
end

function OpenContacts()
    altPlacement = 0
    LoadPlayerContacts()

    BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
    ScaleformMovieMethodAddParamInt(2) 
    ScaleformMovieMethodAddParamInt(altPlacement) 
    EndScaleformMovieMethod()
end

RegisterNetEvent("cl:ifruit:setBombContact", function(bool)
    if bool then 
        AddBomb()
    else 
        RemoveBomb()
    end
end)
