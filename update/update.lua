local function Check(err, response)
    local current = LoadResourceFile(GetCurrentResourceName(), "update/version")
    
    if tonumber(current) < tonumber(response) then 
        print("The Phone resource is outdated. Latest available version: ^2" .. response .. "^7. Your version: ^2" .. current .. "^7")
    elseif tonumber(current) == tonumber(response) then
        return
    else
        print("The Phone resource does not exist. Latest available version: ^2" .. response .. "^7. Your version: ^2" .. current .. "^7")
    end
end

CreateThread(function()
    PerformHttpRequest("https://raw.githubusercontent.com/PappaNiels/FiveM-iFruit-Phone/master/update/version", Check, "GET")
end)