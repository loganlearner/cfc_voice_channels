--[[
    -- Channel Structure --

    Channel
        password protected    | 
        password              |
        User list             | connected users
        owner                 | owner entity
        ownerName             | Name of the owner
        timeout               | time it takes for a channel to time out
]]

local function tooLong(name)
    local maxLength = 15
    return #name > maxLength
end

local function ownsChannel(ply)
    for _, channel in pairs(cfc_voice.Channels) do
        if channel.Owner == ply then
            return true
        end
    end

    return false
end

local function hasPassword(str)
    return not (str == "")
end

function cfc_voice:CreateChannel(caller, name, password)
    if not IsValid(caller) then return end

    local channelName = name
    local isPasswordProtected = hasPassword(password)
    local channelPassword = password

    if tooLong(name) then
        -- Throw error here too
        return
    end

    if ownsChannel(caller) then
        -- Can only own one channel error
        return
    end

    if not cfc_voice:isUniqueChannelName(channelName) then
        -- Error message here!
        return 
    end

    cfc_voice.Channels[table.Count(cfc_voice.Channels) + 1] = {
        ["Name"] = channelName,
        ["Owner"] = caller,
        ["OwnerName"] = caller:Name(),
        ["Password"] = channelPassword,
        ["IsProtected"] = isPasswordProtected,
        ["TimeOut"] = nil,
        ["Users"] = {caller}
    }

    -- TODO: Notify players of successful creation of channel
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

net.Receive("iWannaMakeAChannel", function(len, ply)
    local channelName = net.ReadString()
    local channelPassword = net.ReadString()

    cfc_voice:CreateChannel(ply, channelName, channelPassword)
end)