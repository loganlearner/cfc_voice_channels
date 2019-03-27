--[[
    -- Channel Structure --

    Channel
        Index                 | Index of the channel
        password protected    | 
        password              |
        User list             | connected users
        owner                 | owner entity
        ownerName             | Name of the owner
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

local function isCorrectPassword(channel, passwordAttempt)
    return (passwordAttempt == channel.Password) or (not self.IsProtected)
end

function cfc_voice:isInSameCFCVoiceChannel(listener, talker)
    if listener:isInChannel() or talker:isInChannel() then
        local listenerChannel = listener:getConnectedChannel()
        local talkerChannel = talker:getConnectedChannel()

        if listenerChannel == talkerChannel then 
            return true
        end

        return false
    end

    return true
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

    local i = table.Count(cfc_voice.Channels) + 1
    cfc_voice.Channels[i] = {
        ["Index"] = i,
        ["Name"] = channelName,
        ["TrimmedName"] = string.lower(string.Trim(channelName)),
        ["Owner"] = caller,
        ["OwnerName"] = caller:Name(),
        ["Password"] = channelPassword,
        ["IsProtected"] = isPasswordProtected,
        ["Users"] = {caller}
    }

    -- TODO: Notify players of successful creation of channel
end

function cfc_voice:isUniqueChannelName(name)
    for _, channel in pairs(cfc_voice.Channels) do
        if channel.TrimmedName == string.lower(string.Trim(name)) then
            return false
        end
    end

    return true
end

function cfc_voice:getChannel(channelName)
    for _, channel in pairs(self.Channels) do
        if channel.TrimmedName == string.lower(string.Trim(channelName)) then
            return channel
        end
    end
end

function cfc_voice:canJoinChannel(ply)
    return not ply:isInChannel()
end

function cfc_voice:joinChannel(ply, channel)
    -- TODO: Alert other members of channel that player has joined

    table.insert(channel.Users, ply)
end

function cfc_voice:onChannelPlayerDisconnect(channel)
    if table.Count(channel.Users) <= 0 then
        table.remove(self.Channels, channel.Index)
    end
end

function cfc_voice:leaveChannel(ply, channel)
    -- TODO: Alert player of successful leave
    table.RemoveByValue(channel.Users, ply)
    cfc_voice:onChannelPlayerDisconnect(channel)
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

net.Receive("iWannaJoinPls", function(len, ply)
    local channelName = net.ReadString()
    local channelPassword = net.ReadString()
    
    if not cfc_voice:canJoinChannel(ply) then return end

    local channel = cfc_voice:getChannel(channelName)

    if channel == nil then 
        -- invalid channel error
        return 
    end

    if not isCorrectPassword(channel, channelPassword) then 
        -- wrong password error
        return 
    end

    cfc_voice:joinChannel(ply, channel) 
end)

net.Receive("iLeaveNow", function(len, ply)
    if not ply:isInChannel() then return end

    local channel = ply:getConnectedChannel()
    cfc_voice:leaveChannel(ply, channel)
end)