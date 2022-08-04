contacts = {
    2
}

assistant = "char_pa_female" -- char_pa_male
enableStandardContacts = true

standardContacts = { -- char_detonatebomb
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
    --{"Yohan", "char_yohan"},
    {"Yung Ancestor", "char_tw"}
}

local function LoadPlayerContacts()
    LoadTexture("char_default")
    contacts = GetActivePlayers()
    for i = 1, #contacts + #standardContacts do 
        if i <= #contacts then 
            BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
            ScaleformMovieMethodAddParamInt(2) -- Type
            ScaleformMovieMethodAddParamInt(i - 1) -- Position
            ScaleformMovieMethodAddParamBool(false)  -- !
            ScaleformMovieMethodAddParamPlayerNameString(GetName(contacts[i])) -- Text
            ScaleformMovieMethodAddParamTextureNameString("char_default") -- Profile picture
            ScaleformMovieMethodAddParamTextureNameString("char_default") -- Profile picture
            EndScaleformMovieMethod()
        elseif i > #contacts and enableStandardContacts then
            LoadTexture(standardContacts[i - #contacts][2]) 
            BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
            ScaleformMovieMethodAddParamInt(2) -- Type
            ScaleformMovieMethodAddParamInt(i - 1) -- Position
            ScaleformMovieMethodAddParamBool(false)  -- !
            ScaleformMovieMethodAddParamPlayerNameString(standardContacts[i - #contacts][1]) -- Text
            ScaleformMovieMethodAddParamTextureNameString(standardContacts[i - #contacts][2]) -- Profile picture
            ScaleformMovieMethodAddParamTextureNameString(standardContacts[i - #contacts][2]) -- Profile picture
            EndScaleformMovieMethod()
        end
    end
end

local function AddBomb() -- To do
    UnloadContacts()
end

local function RemoveBomb() -- To do
    UnloadContacts()
end

function UnloadContacts()
    BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT_EMPTY")
    ScaleformMovieMethodAddParamInt(2)
    EndScaleformMovieMethod()
end

function OpenContacts()
    LoadPlayerContacts()

    BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
    ScaleformMovieMethodAddParamInt(2) 
    ScaleformMovieMethodAddParamInt(altPlacement) 
    EndScaleformMovieMethod()
end

RegisterNetEvent("cl:ifruit:addBomb", AddBomb)
RegisterNetEvent("cl:ifruit:removeBomb", RemoveBomb)