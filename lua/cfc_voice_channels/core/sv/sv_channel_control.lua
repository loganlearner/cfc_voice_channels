--[[
    Channel
        password protected    | 
        password              |
        User list             | connected users
        owner                 | owner entity
        ownerName             | Name of the owner
        timeout               | time it takes for a channel to time out
]]

local function hasPassword(str)
    return not (str == "")
end

function cfc_voice:CreateChannel(caller, name, password)
    if not IsValid(caller) then return end

    local channelName = name
    local isPasswordProtected = hasPassword(password)
    local channelPassword = password

    if not cfc_voice:isUniqueChannelName(channelName) then return end

    cfc_voice.Channels[table.Count(cfc_voice.Channels) + 1] = {
        ["Name"] = channelName,
        ["Owner"] = caller,
        ["OwnerName"] = caller:Name(),
        ["Password"] = channelPassword,
        ["IsProtected"] = isPasswordProtected,
        ["TimeOut"] = nil,
        ["Users"] = {}
    }

    -- TODO: Notify player of successful creation of channel
end

function cfc_voice:isUniqueChannelName(name)
    for _, channel in pairs(cfc_voice.Channels) do
        if string.lower(string.Trim(channel.Name)) == string.lower(string.Trim(name)) then
            return false
        end
    end

    return true
end

net.Receive("gimmeChannelsPls", function(len, ply)
    if IsValid(ply) and ply:IsPlayer() then -- TODO: Add IsValidPly when cfc_lib is released
        net.Start("okiHereYouGo")
            net.WriteTable(cfc_voice.Channels)
        net.Send(ply)
    end
end)